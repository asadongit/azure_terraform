#!/bin/bash
set -euo pipefail

: "${LUN:?LUN not set}"
: "${VG_NAME:?VG_NAME not set}"
: "${LV_NAME:?LV_NAME not set}"
: "${MOUNT_POINT:?MOUNT_POINT not set}"

log() { echo "[$(date '+%F %T')] $1"; }

DEVICE="/dev/disk/azure/data/by-lun/${LUN}"
LV_PATH="/dev/${VG_NAME}/${LV_NAME}"

FILESYSTEM=$(findmnt -n -o FSTYPE "${MOUNT_POINT}" 2>/dev/null || true)

if [ -z "${FILESYSTEM}" ]; then
    log "ERROR: Unable to determine filesystem type for ${MOUNT_POINT}"
    exit 1
fi

log "Detected filesystem: ${FILESYSTEM}"

[ -b "${DEVICE}" ] || { log "ERROR: No block device found for Azure LUN ${LUN}"; exit 1; }
log "Using block device ${DEVICE}"

echo 1 > "/sys/class/block/$(basename "$(readlink -f "${DEVICE}")")/device/rescan" 2>/dev/null || true

# Trust the kernel to update device size automatically for NVMe
NEW_SIZE_BYTES=$(blockdev --getsize64 "${DEVICE}")
log "Device ${DEVICE} reports size: ${NEW_SIZE_BYTES} bytes"

log "Resizing PV on ${DEVICE}..."
pvresize "${DEVICE}"

log "Extending LV ${LV_PATH} to consume all free space in VG ${VG_NAME}..."
lvextend -l +100%FREE "${LV_PATH}"

log "Growing ${FILESYSTEM} filesystem on ${LV_PATH}..."
case "${FILESYSTEM}" in
  ext4|ext3|ext2)
    resize2fs "${LV_PATH}"
    ;;
  xfs)
    xfs_growfs "${MOUNT_POINT}"
    ;;
  *)
    log "ERROR: Unsupported filesystem '${FILESYSTEM}' for online resize"
    exit 1
    ;;
esac

df -h "${MOUNT_POINT}"
log "LVM extend completed successfully for ${MOUNT_POINT}."

LOGFILE="/var/log/lvm_extend.log"
exec >>"$LOGFILE" 2>&1

