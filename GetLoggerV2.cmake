include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(LoggerV2
  GIT_REPOSITORY  https://github.com/mel00010/LoggerV2.git
  GIT_TAG         master
)

FetchContent_GetProperties(LoggerV2)
if(NOT LoggerV2_POPULATED)
  FetchContent_Populate(LoggerV2)
  cmake_policy(SET CMP0069 NEW)
  add_subdirectory("${loggerv2_SOURCE_DIR}" "${loggerv2_BINARY_DIR}")
endif()