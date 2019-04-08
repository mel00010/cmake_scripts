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
	add_subdirectory(${assimp_SOURCE_DIR} ${assimp_BINARY_DIR})
endif()