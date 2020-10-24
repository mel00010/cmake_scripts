include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(VkMemAlloc
	GIT_REPOSITORY	https://github.com/GPUOpen-LibrariesAndSDKs/VulkanMemoryAllocator.git
	GIT_TAG			master
)

FetchContent_GetProperties(VkMemAlloc)
if(NOT vkmemalloc_POPULATED)
	FetchContent_Populate(VkMemAlloc)
	add_library(VulkanMemoryAllocator STATIC "")
	configure_file(${CMAKE_CURRENT_LIST_DIR}/vma_imp.cpp.in ${vkmemalloc_BINARY_DIR}/vma_imp.cpp)
  target_sources(VulkanMemoryAllocator
    PRIVATE
      ${vkmemalloc_BINARY_DIR}/vma_imp.cpp
    PUBLIC
      ${vkmemalloc_SOURCE_DIR}/src/vk_mem_alloc.h
  )
  target_include_directories(VulkanMemoryAllocator
    PUBLIC
      ${vkmemalloc_SOURCE_DIR}/src/
  )
endif()