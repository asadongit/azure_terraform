1. Create User azure CLI command

az vm run-command invoke \
    --resource-group "$RG" \
    --name "$VM" \
    --command-id RunShellScript \
    --scripts @create-user.sh \
    --parameters username="$USERNAME"

2. Delete User azure CLI command

az vm run-command invoke \
  --resource-group "$RG" \
  --name "$VM" \
  --command-id RunShellScript \
  --scripts @delete-user.sh \
  --parameters username="$USERNAME"

3. Unlock User azure CLI command

az vm run-command invoke \
  --resource-group "$RG" \
  --name "$VM" \
  --command-id RunShellScript \
  --scripts @unlock-user.sh \
  --parameters username="$USERNAME"

4. Reset Password azure CLI command

az vm run-command invoke \
  --resource-group "$RG" \
  --name "$VM" \
  --command-id RunShellScript \
  --scripts @reset-password.sh \
  --parameters username="$USERNAME" newpassword="$NEWPASS"
