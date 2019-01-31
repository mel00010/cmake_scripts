include(FetchContent)
set(FETCHCONTENT_QUIET OFF)

FetchContent_Declare(vtk
	GIT_REPOSITORY https://vtk.org/VTK.git
	GIT_TAG v8.1.2
)

FetchContent_GetProperties(vtk)
message(vtk_POPULATED)
if(NOT vtk_POPULATED)
	FetchContent_Populate(vtk)
	add_subdirectory(${vtk_SOURCE_DIR} ${vtk_BINARY_DIR})
	set(VTK_DIR ${vtk_BINARY_DIR})
	find_package(VTK REQUIRED)
	include("${VTK_USE_FILE}")
endif()

#list(APPEND CMAKE_MODULE_PATH "${VTK_DIR}/lib/cmake/vtk-8.90/")



#message("VTK_FOUND:  ${VTK_FOUND}")
#message("VTK_USE_FILE:  ${VTK_USE_FILE}")
#message("VTK_INCLUDE_DIRS:  ${VTK_INCLUDE_DIRS}")
#message("VTK_KITS:  ${VTK_KITS}")
#message("VTK_BUILD_VERSION:  ${VTK_BUILD_VERSION}")
#message("VTK_DIR:  ${VTK_DIR}")
#message("VTK_MAJOR_VERSION:  ${VTK_MAJOR_VERSION}")
#message("VTK_LIBRARY_DIRS:  ${VTK_LIBRARY_DIRS}")
#message("VTK_LIBRARIES:  ${VTK_LIBRARIES}")