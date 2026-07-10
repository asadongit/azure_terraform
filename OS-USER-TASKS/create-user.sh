#!/bin/bash
set -euo pipefail

if id -u "$username" >/dev/null 2>&1; then
    echo "User already exists."
    exit 0
fi

useradd -m "$username"

passwd -l "$username"

echo "User $username created successfully."
