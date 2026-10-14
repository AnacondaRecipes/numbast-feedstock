#!/bin/bash
set -exuo pipefail

pushd numbast
# Upstream's console script targets numbast.tool, which does not exist in 0.10.1
# (fixed after the release in https://github.com/NVIDIA/numbast/pull/403).
sed -i 's|"numbast.tool:static_binding_generator"|"numbast.tools.static_binding_generator:static_binding_generator"|' pyproject.toml
grep -q '"numbast.tools.static_binding_generator:static_binding_generator"' pyproject.toml
export SETUPTOOLS_SCM_PRETEND_VERSION_FOR_NUMBAST="${PKG_VERSION}"
${PYTHON} -m pip install . -vv --no-deps --no-build-isolation
popd
