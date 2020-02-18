include(ExternalProject)
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(slang
	GIT_REPOSITORY https://github.com/shader-slang/slang.git
	GIT_TAG v0.13.7
)

FetchContent_GetProperties(slang)
if(NOT slang_POPULATED)
	FetchContent_Populate(slang)
	ExternalProject_Add(slang
			SOURCE_DIR			"${slang_SOURCE_DIR}"
			CONFIGURE_COMMAND	premake5 gmake --cc=clang
			BUILD_IN_SOURCE		TRUE
			BUILD_COMMAND		make config=release_x64
			INSTALL_COMMAND		""
			BUILD_BYPRODUCTS	${slang_SOURCE_DIR}/bin/linux-x64/release/libslang-glslang.so
								${slang_SOURCE_DIR}/bin/linux-x64/release/libslang.so
	)
	add_library(Slang INTERFACE)
	add_dependencies(Slang slang)
	target_include_directories(Slang
		INTERFACE
			${slang_SOURCE_DIR}
	)
	target_sources(Slang
		INTERFACE
			${slang_SOURCE_DIR}/slang.h
			${slang_SOURCE_DIR}/slang-com-helper.h
			${slang_SOURCE_DIR}/slang-com-ptr.h
			${slang_SOURCE_DIR}/slang-tag-version.h
			${slang_SOURCE_DIR}/prelude/slang-cpp-prelude.h
			${slang_SOURCE_DIR}/prelude/slang-cpp-scalar-intrinsics.h
			${slang_SOURCE_DIR}/prelude/slang-cpp-types.h
			${slang_SOURCE_DIR}/prelude/slang-cuda-prelude.h
	)
	target_link_libraries(Slang
		INTERFACE
			${slang_SOURCE_DIR}/bin/linux-x64/release/libslang-glslang.so
			${slang_SOURCE_DIR}/bin/linux-x64/release/libslang.so
	)
endif()