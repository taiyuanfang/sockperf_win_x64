cmake_minimum_required(VERSION 3.10)

project(SOCKPERF)

message("CMAKE_SYSTEM_NAME : ${CMAKE_SYSTEM_NAME}")
message("CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}")
message("CMAKE_SYSTEM_VERSION: ${CMAKE_SYSTEM_VERSION}")
message("UNIX: ${UNIX}")
message("WIN32: ${WIN32}")
message("CMAKE_GENERATOR: ${CMAKE_GENERATOR}")

file(GLOB SOURCES RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
    src/*.cpp
)

if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
    add_definitions(-D__windows__)
    list(REMOVE_ITEM SOURCES src/vma-xlio-redirect.cpp)
    set(sys_libs Ws2_32.lib Dbghelp.lib)
else()
    add_definitions(-D__USE_BSD)
    set(sys_libs pthread dl)
endif()

list(REMOVE_ITEM SOURCES src/sockperf.cpp)
#message("SOURCES: ${SOURCES}")

set(TARGET_NAME sockperf_static)
add_library(${TARGET_NAME}
    ${SOURCES}
)
target_include_directories(${TARGET_NAME} PUBLIC
    src
)
target_link_libraries(${TARGET_NAME} PUBLIC
    ${sys_libs}
)

set(TARGET_NAME sockperf)
add_executable(${TARGET_NAME}
    src/sockperf.cpp
)
target_include_directories(${TARGET_NAME} PRIVATE
    src
)
target_link_libraries(${TARGET_NAME} PRIVATE
    sockperf_static
)

set(TARGET_NAME datetime)
add_executable(${TARGET_NAME}
    datetime.c
)
