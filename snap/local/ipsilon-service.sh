#!/bin/bash -x

export PATH="$SNAP/bin:$PATH"
export PYTHONPATH="$SNAP/lib/python3.8/site-packages:$SNAP/usr/lib/python3/dist-packages"

if [ ! -e "$SNAP_COMMON/cache" ]; then
  mkdir "$SNAP_COMMON/cache"
fi

if [ ! -f "$SNAP_COMMON/ipsilon.conf" ]; then
  cp $SNAP/ipsilon.conf $SNAP_COMMON/ipsilon.conf
fi

if [ ! -f "$SNAP_COMMON/adminconfig.sqlite" ]; then
  ipsilon-upgrade-database "$SNAP_COMMON/ipsilon.conf"
fi

if [ ! -e "$SNAP_COMMON/ui" ]; then
  ln -s /snap/openidc-test-ipsilon/current/share/ipsilon/ui $SNAP_COMMON/
fi

if [ ! -e "$SNAP_COMMON/themes" ]; then
  ln -s /snap/openidc-test-ipsilon/current/share/ipsilon/themes $SNAP_COMMON/
fi

cd $SNAP_COMMON
ipsilon "$SNAP_COMMON/ipsilon.conf"
