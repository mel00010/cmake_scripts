function(setup_dictionary_targets)
	add_custom_target(sort_dictionary
		COMMAND sort ${CMAKE_BINARY_DIR}/dictionary -o ${CMAKE_SOURCE_DIR}/dictionary_sorted
	)
	add_custom_target(regen_dictionary
		COMMAND ${CMAKE_COMMAND} -E copy
				${CMAKE_SOURCE_DIR}/dictionary_sorted
                ${CMAKE_BINARY_DIR}/dictionary
    )
endfunction()