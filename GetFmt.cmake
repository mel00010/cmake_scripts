include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(fmt
	GIT_REPOSITORY	https://github.com/fmtlib/fmt.git
	GIT_TAG			master
)

FetchContent_GetProperties(fmt)
if(NOT fmt_POPULATED)
	FetchContent_Populate(fmt)
	add_subdirectory(${fmt_SOURCE_DIR} ${fmt_BINARY_DIR})
endif()