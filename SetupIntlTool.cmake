find_package (Intl REQUIRED)
find_package(Gettext REQUIRED)
include_directories(${INTL_INCLUDE_DIRS})
link_directories(${INTL_LIBRARY_DIRS})

find_program(gettext_msgfmt_executable msgfmt)

if(NOT gettext_msgfmt_executable)
    message("------
    NOTE: msgfmt not found. Translations will *not* be installed
------")
else(NOT gettext_msgfmt_executable)

  set(catalogname rkward)

  file(GLOB po_files *.po)
  set(gmo_files)

  foreach(_poFile ${po_files})
    get_filename_component(_poFileName ${_poFile} NAME)
    string(REGEX REPLACE "^${catalogname}_?" "" _langCode ${_poFileName} )
    string(REGEX REPLACE "\\.po$" "" _langCode ${_langCode} )

    if( _langCode )
      get_filename_component(_lang ${_poFile} NAME_WE)
      set(_gmoFile ${CMAKE_CURRENT_BINARY_DIR}/${_lang}.gmo)

      add_custom_command(OUTPUT ${_gmoFile}
        COMMAND ${gettext_msgfmt_executable} --check -o ${_gmoFile} ${_poFile}
        DEPENDS ${_poFile})
      install(FILES ${_gmoFile} DESTINATION ${LOCALE_INSTALL_DIR}/${_langCode}/LC_MESSAGES/ RENAME ${catalogname}.mo)
      list(APPEND gmo_files ${_gmoFile})
    endif( _langCode )

  endforeach(_poFile ${po_files})

  add_custom_target(translations ALL DEPENDS ${gmo_files})

endif(NOT gettext_msgfmt_executable)