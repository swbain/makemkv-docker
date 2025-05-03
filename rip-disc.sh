#!/bin/bash

# Script to convert VIDEO_TS folders to MKV using MakeMKV CLI in Docker

# Check if input and output directories exist, create if not
if [ ! -d "input" ]; then
    mkdir -p input
    echo "Created input directory. Please place your VIDEO_TS folders in the input directory."
    exit 1
fi

if [ ! -d "output" ]; then
    mkdir -p output
fi

# Display usage if no arguments provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 [source_folder] [all|<title_number>]"
    echo "Examples:"
    echo "  $0 MOVIE_1           # Convert all titles from input/MOVIE_1 folder"
    echo "  $0 MOVIE_1 0         # Convert only title 0 from input/MOVIE_1 folder"
    echo "  $0 MOVIE_1/VIDEO_TS  # Specify a subfolder containing VIDEO_TS"
    exit 1
fi

# Set defaults
SOURCE_FOLDER="$1"
TITLE=${2:-"all"}
SOURCE_PATH="/input/$SOURCE_FOLDER"

# Make sure the folder exists in input directory
if [ ! -d "input/$SOURCE_FOLDER" ]; then
    echo "Error: Folder 'input/$SOURCE_FOLDER' does not exist."
    echo "Please place your video folders in the input directory."
    exit 1
fi

# First, show disc info
echo "Getting information from $SOURCE_FOLDER..."
docker-compose run --rm makemkv -r info "$SOURCE_PATH"

# Confirm conversion
read -p "Do you want to continue converting $TITLE title(s)? (y/n): " CONFIRM
if [[ $CONFIRM != [yY] && $CONFIRM != [yY][eE][sS] ]]; then
    echo "Conversion cancelled."
    exit 0
fi

# Start conversion
echo "Converting $TITLE title(s) from $SOURCE_FOLDER to output/ directory..."
docker-compose run --rm makemkv -r mkv "$SOURCE_PATH" "$TITLE" /output

echo "Conversion complete. Check output/ directory for your files." 