if(CMAKE_GENERATOR MATCHES "Visual Studio")
    message(FATAL_ERROR "Visual Studio generator not supported, use: cmake -G Ninja")
endif()
# set(CMAKE_SYSTEM_NAME "Linux")
# set(CMAKE_SYSTEM_VERSION 1)
# set(CMAKE_SYSTEM_PROCESSOR "aarch64")
# set(CMAKE_C_COMPILER "zig" cc -target aarch64-linux-gnu)
# set(CMAKE_CXX_COMPILER "zig" c++ -target aarch64-linux-gnu)
set(CMAKE_C_COMPILER "zig" cc)
set(CMAKE_CXX_COMPILER "zig" c++)

if(WIN32)
    set(SCRIPT_SUFFIX ".cmd")
else()
    set(SCRIPT_SUFFIX ".sh")
endif()

# This is working (thanks to Simon for finding this trick)
set(CMAKE_AR "${CMAKE_CURRENT_LIST_DIR}/zig-ar${SCRIPT_SUFFIX}")
set(CMAKE_RANLIB "${CMAKE_CURRENT_LIST_DIR}/zig-ranlib${SCRIPT_SUFFIX}")
