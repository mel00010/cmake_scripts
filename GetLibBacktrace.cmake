include(ExternalProject)
ExternalProject_Add(
  backtrace
  GIT_REPOSITORY https://github.com/ianlancetaylor/libbacktrace.git
  GIT_TAG master
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/_deps/libbacktrace
  CONFIGURE_COMMAND ${CMAKE_CURRENT_BINARY_DIR}/_deps/libbacktrace/configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/_deps/libbacktrace
  BUILD_COMMAND make
  BUILD_IN_SOURCE 1
  BUILD_BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/_deps/libbacktrace/.libs/libbacktrace.a
)
ExternalProject_Add_StepTargets(backtrace build)

add_library(libbacktrace STATIC IMPORTED)
set_target_properties(libbacktrace
    PROPERTIES
    IMPORTED_LOCATION ${CMAKE_CURRENT_BINARY_DIR}/_deps/libbacktrace/.libs/libbacktrace.a)
add_dependencies(libbacktrace backtrace-build)


