include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(range-v3
	GIT_REPOSITORY	https://github.com/ericniebler/range-v3.git
	GIT_TAG			master
)

FetchContent_GetProperties(range-v3)
if(NOT range-v3_POPULATED)
	FetchContent_Populate(range-v3)
	add_subdirectory(${range-v3_SOURCE_DIR} ${range-v3_BINARY_DIR})
endif()