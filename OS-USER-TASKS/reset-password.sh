#!/bin/bash
set -euo pipefail

# Azure injects parameters as environment variables
# so we use $username and $newpassword directly

if ! id -u "$username" >/dev/null 2>&1; then
    echo "User $username does not exist."
    exit 1
fi

# Reset the password
echo "$username:$newpassword" | chpasswd

echo "Password for $username has been reset successfully."

