#!/bin/bash

for modfile in $(dirname $(modinfo -n vboxdrv))/*.ko; do
  echo "Signing $modfile"
  /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 \
                                /root/.kernel_keys/mod_key.priv \
                                /root/.kernel_keys/mod_key.der "$modfile"
  modfile=${modfile##*/}
  modfile=${modfile%.*}
  echo "Inserting $modfile"
  modprobe $modfile
done
