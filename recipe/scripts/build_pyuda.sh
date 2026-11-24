#!/bin/bash

export UDA_PYTHON_SHARED=1
"${PYTHON}" -m pip install --no-deps --no-build-isolation "${PREFIX}/python_installer"
