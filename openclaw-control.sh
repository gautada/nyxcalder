#!/bin/sh
cd /opt/openclaw || exit
# first_arg="${1}"
shift
pnpm openclaw "${@}"
