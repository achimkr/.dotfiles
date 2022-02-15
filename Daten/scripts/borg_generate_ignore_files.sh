#!/bin/bash
find . -iname "Cargo.toml" -print0 | xargs -0 dirname | awk '{print $0 "/target" }' | xargs -d '\n' realpath - 2> /dev/null
