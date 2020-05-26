if (NOT DEFINED WORKSPACE_PATH)
    set(WORKSPACE_PATH $ENV{HOME}/workspace)
endif ()

if (NOT DEFINED DICTIONARY_LOCATION)
    set(DICTIONARY_LOCATION ${WORKSPACE_PATH}/dictionary)
endif ()


function(setup_dictionary_targets)
  configure_file(
    ${CMAKE_SOURCE_DIR}/dictionary_sorted
    ${CMAKE_BINARY_DIR}/dictionary
  )
  add_custom_target(sort_dictionary ALL
    COMMAND sort ${CMAKE_BINARY_DIR}/dictionary -o ${CMAKE_SOURCE_DIR}/dictionary_sorted
  )
  add_custom_target(regen_dictionary ALL
    COMMAND ${CMAKE_COMMAND} -E copy
        ${CMAKE_SOURCE_DIR}/dictionary_sorted
                ${CMAKE_BINARY_DIR}/dictionary
    )
    add_custom_target(link_dictionary ALL
      COMMAND ln -sf ${CMAKE_BINARY_DIR}/dictionary ${DICTIONARY_LOCATION}
    )
endfunction()
