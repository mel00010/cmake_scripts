include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(assimp
  GIT_REPOSITORY https://github.com/assimp/assimp.git
  GIT_TAG master
)

FetchContent_GetProperties(assimp)
message(assimp_POPULATED)
if(NOT assimp_POPULATED)
  FetchContent_Populate(assimp)
  set(ASSIMP_DOUBLE_PRECISION OFF)
  set(ASSIMP_INSTALL OFF)
  set(ASSIMP_ASAN OFF)
  set(ASSIMP_UBSAN OFF)
  set(ASSIMP_BUILD_GLTF_EXPORTER FALSE)
  set(ASSIMP_BUILD_GLTF_IMPORTER FALSE)
  cmake_policy(SET CMP0069 NEW)
#  set(ASSIMP_EXPORTERS_DISABLED GLTF)
#  set(ASSIMP_IMPORTERS_DISABLED GLTF)
  add_subdirectory(${assimp_SOURCE_DIR} ${assimp_BINARY_DIR})
endif()