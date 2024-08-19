#!/bin/bash

print_help() {
  echo "Usage: $0 -i <yaml_file> [-e <extra_options>]"
  echo "  -i <yaml_file>      Specify the YAML file containing key-value pairs"
  echo "  -e <extra_options>  Extra options to pass to svtplay-dl"
  echo "  -h                  Print this help message"
  exit 1
}

# Initialize variables
yaml_file=""
extra_options=""

# Parse command-line options
while getopts ":i:e:h" option; do
  case "${option}" in
    i) yaml_file=${OPTARG};;
    e) extra_options=${OPTARG};;
    h|*) print_help;;
  esac
done

# Validate required options
if [ -z "$yaml_file" ]; then
  echo "Error: Please provide the path to the YAML file using -i."
  exit 1
fi

# Check if the specified file exists
if [ ! -f "$yaml_file" ]; then
  echo "Error: The specified YAML file does not exist."
  exit 1
fi

# Read the YAML file and loop over key-value pairs
# skipping comments and empty lines
grep -v '^#' "$yaml_file" | grep -v "^$" | while IFS=':' read -r key value; do
  # Trim leading/trailing spaces from key and value
  key=$(echo "$key" | xargs)
  value=$(echo "$value" | xargs)

  # Change directory to the local path
  mkdir -p "$key" || exit 1
  cd "$key" || exit 1

  # Build the docker command
  docker_command="docker run --rm -u "$(id -u)":$(id -g) -v "$(pwd):/data" spaam/svtplay-dl -A $value $extra_options"

  # Run the docker command
  echo "Running command: $docker_command"
  eval "$docker_command"
  
  # Go back to the previous directory
  cd - || exit 1
done

