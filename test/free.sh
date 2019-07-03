#!/bin/sh

# This test file relies on the programs 'oscdump' and 'oscsend' which
# are available as part of the LibLo distribution.  Currently they are
# present in the LibLo svn repository, but not yet part of a stable
# release.

# This script assumes Dimple is already running.

# Disable path mangling in MSYS2
export MSYS2_ARG_CONV_EXCL="/world"

# Listen on port 7778.  We'll assume this is the only oscdump instance
# running, and we don't want to run it if it's already running in
# another terminal.
if ! ((ps -A 2>/dev/null || ps -W 2>/dev/null || ps aux 2>/dev/null) | grep oscdump >/dev/null 2>&1 ); then (oscdump 7778 &); fi

oscsend localhost 7774 /world/clear
oscsend localhost 7774 /world/prism/create  sfff p -0.1 0 0
oscsend localhost 7774 /world/sphere/create sfff s  0.1 0 0

oscsend localhost 7774 /world/free/create sss c1 p s

oscsend localhost 7774 /world/c1/response/spring ff 0.001 0.00001

# Push one
oscsend localhost 7774 /world/s/force fff 0.001 0 0