#!/bin/bash

# Uncompress nvidia modules
# unxz $(dirname $(modinfo -n nvidia))/*.xz

# Regenerate modules dep
depmod -a

# Sign modules
for modfile in $(dirname $(modinfo -n nvidia))/*.ko; do
  echo "Signing $modfile"
  /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 \
                                .kernel/vivobook_key.priv \
                                .kernel/vivobook_key.der "$modfile"
done

# Install module
echo "Inserting nvidia"
modprobe nvidia

