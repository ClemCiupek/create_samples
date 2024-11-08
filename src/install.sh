#!/bin/bash

# Ask the user for the path to their dataverse repo (default: ../)
promt_def_dir=$(cd .. && dirs)/dataverse-marketplace-dbt
def_dir=$(cd .. && pwd)/dataverse-marketplace-dbt
read -p "Enter the path to your dataverse repo [${promt_def_dir}]: " dataverse_repo
dataverse_repo=${dataverse_repo:-${def_dir}}

# Ask the user for their domain (default: marketing)
read -p "Enter your domain [marketing]: " domain
domain=${domain:-marketing}

# Define the target directorys
target_dir="${dataverse_repo}/${domain}/scripts"

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Copy the create_samples script to the target directory
echo "Copying the create_samples script to ${target_dir}..."
cp src/create_samples.sh "$target_dir"

# Give execute permission to the create_samples script
chmod +x "${target_dir}/create_samples.sh"

# Add the script directory to .gitignore if not already ignored
gitignore_file="${dataverse_repo}/.gitignore"
if ! grep -q "^${domain}/script$" "$gitignore_file"; then
    echo "${domain}/script" >> "$gitignore_file"
fi

echo "Installation complete."