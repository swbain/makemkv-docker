# MakeMKV Docker

A Docker container for running MakeMKV, a tool for converting DVD/Blu-ray content to MKV files.

## Requirements

- Docker
- Docker Compose
- Video source folders (like VIDEO_TS)

## Setup

1. Clone this repository
2. Create input and output directories:
   ```bash
   mkdir -p input output
   ```
3. Place your VIDEO_TS folders in the input directory:
   ```
   input/
   └── MOVIE_1/
       └── VIDEO_TS/
           ├── VIDEO_TS.IFO
           ├── VIDEO_TS.VOB
           └── ...
   ```

## Building the Container

```bash
docker-compose build
```

This will create a Docker image with MakeMKV v1.18.1 installed.

## Usage

### Using the Helper Script

The easiest way to convert video folders is using the included script:

```bash
./rip-disc.sh MOVIE_1
```

This will:
1. Analyze the content in `input/MOVIE_1`
2. Show information about available titles
3. Prompt for confirmation
4. Convert all titles to MKV files in the output directory

To convert only a specific title (e.g., title 0):

```bash
./rip-disc.sh MOVIE_1 0
```

### Manual Command Line Usage

If you prefer to use MakeMKV directly with docker-compose commands:

- Show video source information:
  ```bash
  docker-compose run --rm makemkv -r info /input/MOVIE_1
  ```

- Convert all titles:
  ```bash
  docker-compose run --rm makemkv -r mkv /input/MOVIE_1 all /output
  ```

- Convert specific title (e.g., title 0):
  ```bash
  docker-compose run --rm makemkv -r mkv /input/MOVIE_1 0 /output
  ```

### Graphical Interface (Experimental)

To run MakeMKV with GUI support, you need to allow Docker to access your X server:

1. Allow local X connections:
   ```bash
   xhost +local:docker
   ```

2. Uncomment the GUI-related lines in `docker-compose.yml`

3. Run:
   ```bash
   docker-compose run --rm makemkv
   ```

## Customization

To use a different MakeMKV version, edit the Dockerfile and change all occurrences of the version number (currently 1.18.1). You'll need to update:
1. The download URLs
2. The extracted folder paths

## Troubleshooting

- If MakeMKV doesn't recognize your VIDEO_TS folder, make sure it has the correct structure with all required files.
- For nested folders, specify the full path to the VIDEO_TS folder, e.g., `./rip-disc.sh MOVIE_1/VIDEO_TS`
- If you encounter permission issues, check that Docker has proper access to your input and output directories.

## License

This Dockerfile is provided as-is. MakeMKV itself is proprietary software with its own licensing terms. 