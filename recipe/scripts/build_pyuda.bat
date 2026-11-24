@echo off

set "UDA_PYTHON_SHARED=1"
"%PYTHON%" -m pip install --no-deps --no-build-isolation -vvv "%LIBRARY_PREFIX%\python_installer" || exit /b 1
