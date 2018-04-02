# We need thread support
find_package (Threads REQUIRED)

# Download and unpack avr-uart at configure time
configure_file(${CMAKE_SOURCE_DIR}/cmake/AVR-UART.cmake.in  ${CMAKE_BINARY_DIR}/avr-uart-download/CMakeLists.txt)

execute_process(COMMAND ${CMAKE_COMMAND} -G "${CMAKE_GENERATOR}" .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/avr-uart-download )
if(result)
  message(FATAL_ERROR "CMake step for avr-uart failed: ${result}")
endif()
execute_process(COMMAND ${CMAKE_COMMAND} --build .
  RESULT_VARIABLE result
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/avr-uart-download )
if(result)
  message(FATAL_ERROR "Build step for avr-uart failed: ${result}")
endif()


