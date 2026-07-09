#!/bin/bash
set -euo pipefail

: "${LUN:?LUN not set}"
: "${VG_NAME:?VG_NAME not set}"
: "${LV_NAME:?LV_NAME not set}"
: "${MOUNT_POINT:?MOUNT_POINT not set}"
: "${FILESYSTEM:?FILESYSTEM not set}"

log() { echo "[$(date '+%F %T')] $1"; }

DEVICE="/dev/disk/azure/data/by-lun/${LUN}"
LV_PATH="/dev/${VG_NAME}/${LV_NAME}"

[ -b "${DEVICE}" ] || { log "ERROR: No block device found for Azure LUN ${LUN}"; exit 1; }
log "Using block device ${DEVICE}"

log "Creating PV/VG/LV..."
pvcreate "${DEVICE}"
vgcreate "${VG_NAME}" "${DEVICE}"
lvcreate -n "${LV_NAME}" -l 100%FREE "${VG_NAME}"

log "Creating ${FILESYSTEM} filesystem..."
mkfs -t "${FILESYSTEM}" "${LV_PATH}"

mkdir -p "${MOUNT_POINT}"
echo "${LV_PATH} ${MOUNT_POINT} ${FILESYSTEM} defaults,nofail 0 2" >> /etc/fstab

mount "${MOUNT_POINT}"

if mountpoint -q "${MOUNT_POINT}"; then
    log "LVM configured successfully."
else
    log "ERROR: Mount verification failed."
    exit 1
fi