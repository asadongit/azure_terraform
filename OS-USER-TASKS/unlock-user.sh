#!/bin/bash
set -euo pipefail

# Azure injects parameters as environment variables
# so we use $username directly

if ! id -u "$username" >/dev/null 2>&1; then
    echo "User $username does not exist."
    exit 1
fi

# Unlock the account (remove password lock)
passwd -u "$username"

echo "User $username unlocked successfully."
