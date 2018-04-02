# We need thread support
find_package (Threads REQUIRED)

# Download and unpack googletest at configure time
configure_file(${CMAKE_SOURCE_DIR}/cmake/NanoPB.cmake.in  ${CMAKE_BINARY_DIR}/nanopb-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/nanopb-download )
if(result)
  message(FATAL_ERROR "CMake step for nanopb failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/nanopb-download )
if(result)
  message(FATAL_ERROR "Build step for nanopb failed: ${result}")
endif()


