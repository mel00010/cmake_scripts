function(add_shader TARGET SHADER)

  # Find glslc shader compiler.
  # On Android, the NDK includes the binary, so no external dependency.
  if(ANDROID)
    file(GLOB glslc-folders ${ANDROID_NDK}/shader-tools/*)
    find_program(GLSLC REQUIRED glslc NAMES glslc HINTS ${glslc-folders})
  else()
    find_program(GLSLC REQUIRED glslc NAMES glslc)
  endif()

  # All shaders for a sample are found here.
  set(current-shader-path ${CMAKE_CURRENT_SOURCE_DIR}/${SHADER})

  # For Android, write SPIR-V files to app/assets which is then packaged into the APK.
  # Otherwise, output in the binary directory.
  if(ANDROID)
    set(current-output-path ${CMAKE_CURRENT_SOURCE_DIR}/app/assets/shaders/${SHADER}.spv)
  else(ANDROID)
    set(current-output-path ${CMAKE_CURRENT_BINARY_DIR}/${SHADER}.spv)
  endif(ANDROID)

  # Add a custom command to compile GLSL to SPIR-V.
  get_filename_component(current-output-dir ${current-output-path} DIRECTORY)
  file(MAKE_DIRECTORY ${current-output-dir})
  add_custom_command(
    OUTPUT ${current-output-path}
    COMMAND ${GLSLC} -MD -MF ${current-shader-path}.d -o ${current-output-path} ${current-shader-path}
    DEPENDS ${current-shader-path}
    IMPLICIT_DEPENDS CXX ${current-shader-path}
    DEPFILE ${current-shader-path}.d
    VERBATIM)

  # Make sure our native build depends on this output.
  set_source_files_properties(${current-output-path} PROPERTIES GENERATED TRUE)
  target_sources(${TARGET} PRIVATE ${current-output-path})
endfunction(add_shader)