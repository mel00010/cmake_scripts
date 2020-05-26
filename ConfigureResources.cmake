include(array2d)


function(createResourcesTarget DEST_TARGET RESOURCE_DIR)
  add_library(${DEST_TARGET}_Resources INTERFACE)
  target_sources(${DEST_TARGET}_Resources
    INTERFACE
      "${RESOURCE_DIR}/Resources.hpp"
  )
endfunction()

function(target_resources DEST_TARGET TOP_DIR T_NAMESPACE)
  set(RESOURCE_DIR "${TOP_DIR}/resources")
  array2d_begin_loop(advanced "${ARGN}" 4 "Filename;ID;Type;MainFile")
  while(advanced)
#    message("Filename: ${Filename} | ID: ${ID} | Type: ${Type}")
    set(basename "")
    get_filename_component(basename "${Filename}" NAME)
    file(MAKE_DIRECTORY "${RESOURCE_DIR}")
    file(COPY "${Filename}" DESTINATION "${RESOURCE_DIR}")
    if(TARGET ${DEST_TARGET}_Resources)
    else()
      createResourcesTarget("${DEST_TARGET}" "${RESOURCE_DIR}")
    endif()

    add_custom_target(resources_${DEST_TARGET}_${basename}_stamp DEPENDS "${RESOURCE_DIR}/${basename}")
    if(TARGET resources_${DEST_TARGET})
      file(APPEND "${RESOURCE_DIR}/resource_list.txt" "${ID} ${Type} resources/${basename} ${MainFile}\n")
      add_dependencies(resources_${DEST_TARGET} resources_${DEST_TARGET}_${basename}_stamp)
    else()
      file(WRITE "${RESOURCE_DIR}/resource_list.txt" "${ID} ${Type} resources/${basename} ${MainFile}\n")

      include_directories("${RESOURCE_DIR}/")

      add_custom_target(resources_${DEST_TARGET}
        DEPENDS "${RESOURCE_DIR}/Resources.hpp"
      )

      add_custom_command(OUTPUT "${RESOURCE_DIR}/Resources.hpp"
        COMMAND
          python3 "${PROJECT_SOURCE_DIR}/cmake/generateResourcesFile.py"
          "${RESOURCE_DIR}/resource_list.txt"
          "${RESOURCE_DIR}/Resources.hpp"
          "${T_NAMESPACE}"
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
  add_dependencies(${DEST_TARGET}_Resources resources_${DEST_TARGET})
endfunction()