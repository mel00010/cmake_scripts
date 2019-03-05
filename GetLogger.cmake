include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(logger
	GIT_REPOSITORY	https://github.com/mel00010/Logger.git
	GIT_TAG			master
)

FetchContent_GetProperties(logger)
if(NOT logger_POPULATED)
	FetchContent_Populate(logger)
	add_subdirectory(${logger_SOURCE_DIR} ${logger_BINARY_DIR})
endif()