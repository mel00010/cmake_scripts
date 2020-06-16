include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(BoostDI
  GIT_REPOSITORY  https://github.com/boost-experimental/di.git
  GIT_TAG         cpp14
)

FetchContent_GetProperties(BoostDI)
if(NOT BoostDI_POPULATED)
  FetchContent_Populate(BoostDI)
  cmake_policy(SET CMP0069 NEW)
  add_subdirectory("${boostdi_SOURCE_DIR}" "${boostdi_BINARY_DIR}")
  add_library(Boost::DI ALIAS Boost.DI)
endif()