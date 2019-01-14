# We need thread support
find_package (Threads REQUIRED)

# Download and unpack vtk at configure time
configure_file(${CMAKE_SOURCE_DIR}/cmake/VTK.cmake.in  ${CMAKE_BINARY_DIR}/vtk-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/vtk-download )
if(result)
  message(FATAL_ERROR "CMake step for vtk failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/vtk-download )
if(result)
  message(FATAL_ERROR "Build step for vtk failed: ${result}")
endif()


# Add vtk directly to our build. This defines
# the vtk target.
add_subdirectory(${CMAKE_BINARY_DIR}/vtk-src
                 ${CMAKE_BINARY_DIR}/vtk-build)
