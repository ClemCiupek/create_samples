#!/bin/bash

# Ask the user for the path to their dataverse repo (default: ../)
read -p "Enter the path to your dataverse repo (default: ../): " dataverse_repo
dataverse_repo=${dataverse_repo:-../}

# Ask the user for their domain (default: marketing)
read -p "Enter your domain (default: marketing): " domain
domain=${domain:-marketing}

# Define the target directory
target_dir="${dataverse_repo}/${domain}/script"

# Create the target directory if it doesn't exist
mkdir -p "$target_dir"

# Copy the create_samples script to the target directory
cp create_samples.sh "$target_dir"

# Give execute permission to the create_samples script
chmod +x "${target_dir}/create_samples.sh"

# Add the script directory to .gitignore if not already ignored
gitignore_file="${dataverse_repo}/.gitignore"
if ! grep -q "^${domain}/script$" "$gitignore_file"; then
    echo "${domain}/script" >> "$gitignore_file"
fi

echo "Installation complete."