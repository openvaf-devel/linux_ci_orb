#!/bin/bash
set -eux

tee .config/nextest.toml << END
[store]
dir = "target/nextest"
[profile.ci]
retries = 0
test-threads = "num-cpus"
status-level = "pass"
final-status-level = "none"
slow-timeout = { period = "30s" }
leak-timeout = "100ms"
failure-output = "immediate-final"
fail-fast = false

[profile.ci.junit]
path = "junit.xml"
report-name = "nextest-run"
END

cargo-nextest run --partition "count:${CI_NODE_INDEX}/${CI_NODE_TOTAL}" --target "${TARGET}" --binaries-metadata "target/${TARGET}/debug/tests.json"  --cargo-metadata "target/{TARGET}/debug/cargo.json"