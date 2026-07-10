#!/bin/bash
set -euo pipefail

if ! id -u "$username" >/dev/null 2>&1; then
    echo "User $username does not exist."
    exit 0
fi

# Delete the user and their home directory
userdel -r "$username"

echo "User $username deleted successfully."
