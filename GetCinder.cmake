# We need thread support
find_package (Threads REQUIRED)

# Download and unpack cinder at configure time
configure_file(${CMAKE_SOURCE_DIR}/cmake/Cinder.cmake.in  ${CMAKE_BINARY_DIR}/cinder-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/cinder-download )
if(result)
  message(FATAL_ERROR "CMake step for cinder failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/cinder-download )
if(result)
  message(FATAL_ERROR "Build step for cinder failed: ${result}")
endif()

# Add cinder directly to our build. This defines
# the cinder target
add_subdirectory(${CMAKE_BINARY_DIR}/cinder-src
                 ${CMAKE_BINARY_DIR}/cinder-build)

# The cinder target carries header search path
# dependencies automatically when using CMake 2.8.11 or
# later. Otherwise we have to add them here ourselves.
if (CMAKE_VERSION VERSION_LESS 2.8.11)
  include_directories("${cinder_SOURCE_DIR}/include")
endif()
list(APPEND CMAKE_MODULE_PATH "${cinder_SOURCE_DIR}/proj/cmake")
list(APPEND CMAKE_MODULE_PATH "${cinder_SOURCE_DIR}/proj/cmake/modules")

set(CINDER_PATH "${cinder_SOURCE_DIR}")

