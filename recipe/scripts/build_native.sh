#!/bin/bash
set -e

tool_prefix="${PREFIX}"
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" && -z "${CROSSCOMPILING_EMULATOR:-}" ]]; then
  tool_prefix="${BUILD_PREFIX}"
fi
java_bin="${tool_prefix}/lib/jvm/bin"

cmake ${CMAKE_ARGS} -G Ninja \
    -D BUILD_SHARED_LIBS=ON \
    -D SSLAUTHENTICATION=ON \
    -D CLIENT_ONLY=ON \
    -D SERVER_ONLY=OFF \
    -D ENABLE_CAPNP=ON \
    -D CAPNP_EXECUTABLE="${tool_prefix}/bin/capnp" \
    -D CAPNPC_CXX_EXECUTABLE="${tool_prefix}/bin/capnpc-c++" \
    -D NO_MEMCACHE=ON \
    -D NO_WRAPPERS=OFF \
    -D NO_CXX_WRAPPER=OFF \
    -D NO_PYTHON_WRAPPER=OFF \
    -D NO_JAVA_WRAPPER=OFF \
    -D NO_IDL_WRAPPER=ON \
    -D FAT_IDL=OFF \
    -D NO_CLI=OFF \
    -D JAVA_HOME="${PREFIX}/lib/jvm" \
    -D Java_JAVA_EXECUTABLE="${java_bin}/java" \
    -D Java_JAVAC_EXECUTABLE="${java_bin}/javac" \
    -D Java_JAVAH_EXECUTABLE="${java_bin}/java" \
    -D Java_JAR_EXECUTABLE="${java_bin}/jar" \
    -D Java_JARSIGNER_EXECUTABLE="${java_bin}/jarsigner" \
    -B build -S "${SRC_DIR}"

cmake --build build --target install
ln -sf "UDA-${UDA_VERSION}.jar" "${PREFIX}/java/UDA.jar"
