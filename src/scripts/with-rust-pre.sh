#!/bin/bash
set -eux

sccache --version
command -v lld

export SCCACHE_IDLE_TIMEOUT="0"
export RUST_LOG="sccache=info"
export SCCACHE_ERROR_LOG=/tmp/sccache.log
export SCCACHE_LOG="info,sccache::cache=debug"
sccache --start-server

cat << EOF >> "${BASH_ENV}"
  export RUSTC_WRAPPER="sccache"
  export CARGO_INCREMENTAL="0"
  export CARGO_PROFILE_DEV_PANIC="abort"
  export CARGO_PROFILE_DEV_DEBUG="false"
  export CARGO_PROFILE_RELEASE_LTO="fat"
  export CARGO_PROFILE_RELEASE_LTO="1"
  export CARGO_PROFILE_RELEASE_CODEGEN_UNITS="1"
EOF
