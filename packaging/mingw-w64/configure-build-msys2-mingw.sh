$mingw64 cmake -DCMAKE_MAKE_PROGRAM=mingw32-make -G "MinGW Makefiles" \
      -DCMAKE_INSTALL_PREFIX=$PWD/dest/ \
      -DMINGW_BUILD:BOOL=ON \
      -DWITHOUT_WIN32_CONFIG:BOOL=ON \
      -DRDKAFKA_BUILD_EXAMPLES:BOOL=ON \
      -DRDKAFKA_BUILD_TESTS:BOOL=ON \
      -DWITH_LIBDL:BOOL=OFF \
      -DWITH_PLUGINS:BOOL=OFF \
      -DWITH_SASL:BOOL=ON \
      -DWITH_SSL:BOOL=ON \
      -DWITH_ZLIB:BOOL=OFF \
      -DRDKAFKA_BUILD_STATIC:BOOL=OFF \
      -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS:BOOL=TRUE . 1>&2
$mingw64 mingw32-make 1>&2
$mingw64 mingw32-make install 1>&2
cp src/librdkafka.dll src-cpp/librdkafka++.dll tests/test-runner.exe ./dest
export PATH="$PWD/dest/bin:/mingw64/bin/:${PATH}"
./tests/test-runner.exe -l -Q -p1 && ./tests/test-runner.exe -l -Q -p1 -P