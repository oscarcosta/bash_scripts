#!/bin/sh
/usr/bin/time -f '%C u:%Us s:%Ss r:%es m:%MkB' "$@"
