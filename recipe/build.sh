#!/usr/bin/env bash

set -ex

if [[ "${target_platform}" == "osx-arm64" ]]; then
  # avoid "Bad CPU"
  $PYTHON -m pip install . -vv --no-deps --no-build-isolation
else
  # prefer interpreter-specific builds
  maturin build --release --strip --manylinux off --interpreter "${PYTHON}" --out dist
  "${PYTHON}" -m pip install "${SRC_DIR}/dist/nh3*.whl" --no-deps -vv
fi

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
