#!/bin/bash
# This script is a prototype and will not be maintained

# Colors
BLACK="\033[30m"
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
BLUE="\033[34m"
MAGENTA="\033[35m"
CYAN="\033[36m"
WHITE="\033[37m"
RESET="\033[0m"

# Script usage prompt
usage() {
    echo "Usage: $0 [-t target] src1 src2 ... srcN"
    echo "  -t target: Specify the target (default: dev_samples and test_samples)"
    exit 1
}

# Set default targets
targets=("dev_samples" "test_samples")

# Parse command line arguments
while getopts ":t:" opt; do
    case ${opt} in
        t )
            targets=("$OPTARG")
            ;;
        \? )
            usage
            ;;
    esac
done
shift $((OPTIND -1))

# Args check (need at least one source)
if [ $# -lt 1 ]; then
    usage
fi

# List of sources
sources=("$@")

# Function to get the database name from the YAML file
get_database_name() {
    local src_name="$1"
    local external_data_spaces="models/external_data_spaces"
    local ret="Error: external source not found."

    for yaml_file in "$external_data_spaces"/*.yml; do
        if grep -qs "$src_name" "$yaml_file"; then
            ret=$(grep 'database:' "$yaml_file" | awk '{print $2}' | xargs | awk -F ' ' '{print $1}')
            break
        fi
    done

    echo "$ret"
}

# Run the dbt run-operation command for each source and target
for src in "${sources[@]}"; do

    src_db=$(get_database_name "$src")

    for target in "${targets[@]}"; do
        # Command to run and log path
        cmd="dbt run-operation create_sample --args \"{source: ${src}, prod_bq_project: ${src_db}}\" --target $target"
        log_path="logs/create_samples_${src}_${target}.log"

        # Print info
        echo -e "$MAGENTA\rRunning dbt run-operation create_sample for source: $RESET${src}"
        echo -e "\t- database: ${src_db}"
        echo -e "\t- target: ${target}"
        echo -e "\t- cmd: ${cmd}"

        # Execute command
        if eval $cmd > $log_path 2>&1; then
            echo -e "$GREEN\rDone!$RESET"
        else
            echo -e "$YELLOW\rOops something might have gone wrong...$RESET"
        fi

        echo -e "You can check the log file with: cat ${log_path}\n"
    done

done
