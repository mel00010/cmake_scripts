include(array2d)


function(createResourcesTarget RESOURCE_DIR)
	add_library(Resources INTERFACE)
	target_sources(Resources
		INTERFACE
			"${RESOURCE_DIR}/Resources.hpp"
	)
endfunction()

function(target_resources DEST_TARGET TOP_DIR)
	set(RESOURCE_DIR "${TOP_DIR}/resources")
	array2d_begin_loop(advanced "${ARGN}" 3 "Filename;ID;Type")
	while(advanced)
#		message("Filename: ${Filename} | ID: ${ID} | Type: ${Type}")
		set(basename "")
		get_filename_component(basename "${Filename}" NAME)
		file(MAKE_DIRECTORY "${RESOURCE_DIR}")
		configure_file("${Filename}" "${RESOURCE_DIR}/${basename}" COPYONLY)
		if(TARGET Resources)
		else()
			createResourcesTarget("${RESOURCE_DIR}")
		endif()
		add_custom_target(resources_${DEST_TARGET}_${basename}_stamp DEPENDS "${RESOURCE_DIR}/${basename}")
		if(TARGET resources_${DEST_TARGET})
			file(APPEND "${RESOURCE_DIR}/resource_list.txt" "${ID} ${Type} resources/${basename}\n")
			add_dependencies(resources_${DEST_TARGET} resources_${DEST_TARGET}_${basename}_stamp)
		else()
			file(WRITE "${RESOURCE_DIR}/resource_list.txt" "${ID} ${Type} resources/${basename}\n")
		
			include_directories("${RESOURCE_DIR}/")
			
			add_custom_target(resources_${DEST_TARGET}
				DEPENDS "${RESOURCE_DIR}/Resources.hpp"
			)
			
			add_custom_command(OUTPUT "${RESOURCE_DIR}/Resources.hpp"
				COMMAND 
					python3 "${PROJECT_SOURCE_DIR}/cmake/generateResourcesFile.py"
					"${RESOURCE_DIR}/resource_list.txt"
					"${RESOURCE_DIR}/Resources.hpp"
				DEPENDS
					"${PROJECT_SOURCE_DIR}/cmake/generateResourcesFile.py"
					"${RESOURCE_DIR}/resource_list.txt"
					
				COMMENT
					"Generating ${RESOURCE_DIR}/Resources.hpp"
			)
			add_dependencies(${DEST_TARGET} resources_${DEST_TARGET})
		endif()
		
		array2d_advance()
	endwhile()
	add_dependencies(Resources resources_${DEST_TARGET})
endfunction()