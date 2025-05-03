FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install required dependencies for building MakeMKV (CLI only)
RUN apt-get update && apt-get install -y \
    build-essential \
    pkg-config \
    libc6-dev \
    libssl-dev \
    libexpat1-dev \
    libavcodec-dev \
    zlib1g-dev \
    wget \
    less \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /tmp

# Download MakeMKV source packages
RUN wget https://www.makemkv.com/download/makemkv-bin-1.18.1.tar.gz && \
    wget https://www.makemkv.com/download/makemkv-oss-1.18.1.tar.gz && \
    tar -xzf makemkv-oss-1.18.1.tar.gz && \
    tar -xzf makemkv-bin-1.18.1.tar.gz

# Build and install MakeMKV OSS package (CLI only)
WORKDIR /tmp/makemkv-oss-1.18.1
RUN ./configure --disable-gui && \
    make && \
    make install

# Build and install MakeMKV BIN package
WORKDIR /tmp/makemkv-bin-1.18.1
# Auto-accept EULA to avoid interactive prompt
RUN echo "yes" | make && \
    make install

# Clean up build artifacts
WORKDIR /
RUN rm -rf /tmp/makemkv*

# Install additional runtime dependencies
RUN apt-get update && apt-get install -y \
    libavcodec-extra \
    ccextractor \
    && rm -rf /var/lib/apt/lists/*

# Create volume for output files
VOLUME /output

# Set working directory
WORKDIR /output

# Command to run when container starts
ENTRYPOINT ["makemkvcon"] 