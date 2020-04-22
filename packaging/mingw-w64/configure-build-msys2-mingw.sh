$mingw64 cmake -DCMAKE_MAKE_PROGRAM=mingw32-make -G "MinGW Makefiles" \
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
cp /mingw64/bin/{libwinpthread-1.dll,libgcc_s_seh-1.dll,libstdc++-6.dll,libssl-1*.dll,libcrypto-1*.dll} src/librdkafka.dll src-cpp/librdkafka++.dll ./tests
cd tests && ./test-runner.exe -l -Q -p1 && ./test-runner.exe -l -Q -p1 -P