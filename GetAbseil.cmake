include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(abseil
  GIT_REPOSITORY  https://github.com/abseil/abseil-cpp.git
  GIT_TAG         master
)

FetchContent_GetProperties(abseil)
if(NOT abseil_POPULATED)
  list( APPEND LLVM_FLAGS "-fPIC" )
  list( APPEND GCC_FLAGS "-fPIC" )
  FetchContent_Populate(abseil)
  add_subdirectory(${abseil_SOURCE_DIR} ${abseil_BINARY_DIR})
endif()