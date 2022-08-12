#!/bin/bash
set -eux

mkdir -p .config
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

cargo-nextest run --partition "count:${CIRCLE_NODE_INDEX}/${CIRCLE_NODE_TOTAL}" --target "${TARGET}" --archive-file="${ARCHIVE}"
mkdir test-results 
circleci-junit-fix > test-results/junit.xml < target/nextest/junit.xml
