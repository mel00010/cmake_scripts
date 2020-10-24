function(add_resource TARGET RESOURCE)
add_custom_command(
        TARGET ${TARGET} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                ${CMAKE_CURRENT_SOURCE_DIR}/${RESOURCE}
                $<TARGET_FILE_DIR:${TARGET}>/${RESOURCE})
endfunction(add_resource)
