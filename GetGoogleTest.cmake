include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(googletest
	GIT_REPOSITORY	https://github.com/google/googletest.git
	GIT_TAG			master
)

FetchContent_GetProperties(googletest)
if(NOT googletest_POPULATED)
	FetchContent_Populate(googletest)
	add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})
endif()