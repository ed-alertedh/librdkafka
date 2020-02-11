# the name of the target operating system
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

SET(PREFIX x86_64-w64-mingw32)
SET(CMAKE_MAKE_PROGRAM mingw32-make)
SET(CMAKE_C_COMPILER   ${PREFIX}-gcc)
SET(CMAKE_CXX_COMPILER ${PREFIX}-g++)
SET(CMAKE_AR ${PREFIX}-gcc-ar)
SET(CMAKE_NM ${PREFIX}-gcc-nm)
SET(CMAKE_RC_COMPILER  windres)

# specify the cross linker
SET(CMAKE_RANLIB ${PREFIX}-gcc-ranlib)

# where is the target environment
SET(CMAKE_FIND_ROOT_PATH /opt/mingw64 /usr/${PREFIX})

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search
# programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(MINGW_BUILD ON)