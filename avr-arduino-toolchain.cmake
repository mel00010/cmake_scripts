# AVR/Arduino CMake toolchain
#
# adds the toolchain and Arduino IDE libs
#
# @author Matthias L. Jugel <leo@ubirch.com>
#
# == LICENSE ==
# Copyright 2015 ubirch GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.0)

# find compiler and toolchain programs
find_program(AVRCPP avr-g++)
find_program(AVRC avr-gcc)
find_program(AVRAR avr-ar)
find_program(AVRSTRIP avr-strip)
find_program(OBJCOPY avr-objcopy)
find_program(OBJDUMP avr-objdump)
find_program(AVRSIZE avr-size)
find_program(AVRDUDE avrdude)
find_program(SCREEN screen)
find_program(SIMAVR simavr)


# toolchain settings
#set(CMAKE_SYSTEM_NAME Generic)
#set(CMAKE_CXX_COMPILER "${AVRCPP}")
#set(CMAKE_C_COMPILER "${AVRC}")
#set(CMAKE_AR "${AVRAR}")
#set(CMAKE_ASM_COMPILER "${AVRC}")

# toolchain settings
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_CXX_COMPILER /home/mel/git/Arduino/build/linux/work/hardware/tools/avr/bin/avr-g++)
set(CMAKE_C_COMPILER /home/mel/git/Arduino/build/linux/work/hardware/tools/avr/bin/avr-gcc)
set(CMAKE_AR /home/mel/git/Arduino/build/linux/work/hardware/tools/avr/bin/avr-gcc-ar)
set(CMAKE_ASM_COMPILER /home/mel/git/Arduino/build/linux/work/hardware/tools/avr/bin/avr-gcc)



# Important project paths
set(BASE_PATH "${${PROJECT_NAME}_SOURCE_DIR}")
set(SRC_PATH "${BASE_PATH}/src")
set(LIB_PATH "${BASE_PATH}/lib")

# necessary settings for the chip we use
if (NOT DEFINED MCU)
    set(MCU atmega2560)
endif ()
if (NOT DEFINED F_CPU)
    set(F_CPU 16000000)
endif ()
if (NOT DEFINED BAUD)
    set(BAUD 115200)
endif ()
if (NOT DEFINED PROGRAMMER)
    set(PROGRAMMER arduino)
endif ()
if (NOT DEFINED MONITOR)
    set(MONITOR ${SCREEN})
endif ()
if (NOT DEFINED MONITOR_ARGS)
    set(MONITOR_ARGS ${SERIAL_DEV} ${BAUD})
endif ()
if (NOT DEFINED SIMAVR_ARGS)
    set(SIMAVR_ARGS --gdb --mcu ${MCU} --freq ${F_CPU})
endif ()


SET(CMAKE_FIND_LIBRARY_SUFFIXES ".a")
SET(BUILD_SHARED_LIBRARIES OFF)
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

set(CMAKE_C_FLAGS "-std=gnu11 -mcall-prologues -ffunction-sections -fdata-sections -O3 -Wall -Wno-unknown-pragmas -Wextra -MMD -mmcu=${MCU} -fdiagnostics-color=always" CACHE STRING "")
set(CMAKE_CXX_FLAGS "-std=c++11 -felide-constructors -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -O3 -Wall -Wno-unknown-pragmas -Wextra -MMD -mmcu=${MCU} -fdiagnostics-color=always" CACHE STRING "")
set(CMAKE_ASM_FLAGS "-x assembler-with-cpp -O3 -Wall -Wno-unknown-pragmas -Wextra -MMD -mmcu=${MCU}" CACHE STRING "")
set(CMAKE_EXE_LINKER_FLAGS "-static -Wl,--relax -Wl,--gc-sections -Wl,-u,vfscanf -lscanf_min -Wl,-u,vfprintf -lprintf_min ${EXTRA_LIBS}" CACHE STRING "")

set(CMAKE_C_FLAGS_RELEASE "-std=gnu11 -mcall-prologues -ffunction-sections -fdata-sections -O3 -Wall -Wno-unknown-pragmas -Wextra -MMD -mmcu=${MCU} -fdiagnostics-color=always" CACHE STRING "")
set(CMAKE_CXX_FLAGS_RELEASE "-std=c++11 -felide-constructors -fpermissive -fno-exceptions -ffunction-sections -fdata-sections -fno-threadsafe-statics -O3 -Wall -Wno-unknown-pragmas -Wextra -MMD -mmcu=${MCU} -fdiagnostics-color=always" CACHE STRING "")
set(CMAKE_ASM_FLAGS_RELEASE "-x assembler-with-cpp -O3 -Wall -Wno-unknown-pragmas -Wextra -MMD -mmcu=${MCU}" CACHE STRING "")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE "-static -Wl,--relax -Wl,--gc-sections -Wl,-u,vfscanf -lscanf_min -Wl,-u,vfprintf -lprintf_min ${EXTRA_LIBS}" CACHE STRING "")



# some definitions that are common
add_definitions(-DMCU=${MCU})
add_definitions(-DF_CPU=${F_CPU})
add_definitions(-DBAUD=${BAUD})
add_definitions(-DARDUINO=10806)
add_definitions(-DARDUINO_AVR_MEGA2560)
add_definitions(-DARDUINO_ARCH_AVR)
add_definitions(-mmcu=${MCU})
add_compile_options(-gstabs)
add_compile_options(-funsigned-char)
add_compile_options(-funsigned-bitfields)
add_compile_options(-fpack-struct)
add_compile_options(-fshort-enums)
add_compile_options(-fno-exceptions)
add_compile_options(-ffunction-sections)
add_compile_options(-fdata-sections)
add_compile_options(-Os)
add_compile_options(-Wall)
add_compile_options(-Wno-unknown-pragmas)
add_compile_options(-Wextra)
add_compile_options(-MMD)
add_compile_options(-fdiagnostics-color=always)

add_compile_options(-fuse-linker-plugin)
add_compile_options(-flto)
add_compile_options(-Wl,--gc-sections)
add_compile_options(-std=gnu++11)
add_compile_options(-felide-constructors)
add_compile_options(-fpermissive)
add_compile_options(-fno-threadsafe-statics)


# we need a little function to add multiple targets
function(add_executable_avr NAME)       
    if (DEFINED MCU_REQUIRED AND (NOT (MCU STREQUAL "${MCU_REQUIRED}")))
        message(STATUS "Ignoring target ${NAME} (required MCU '${MCU_REQUIRED}' != '${MCU}')")
    else ()
        add_executable(${NAME} ${ARGN})
        set_target_properties(${NAME} PROPERTIES OUTPUT_NAME "${NAME}.elf")
        set_target_properties(${NAME} PROPERTIES LINK_FLAGS " -Wall -Wextra -Os -g -flto -fuse-linker-plugin -Wl,--gc-sections,--relax -mmcu=atmega2560" )
        
        set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${NAME}.hex;${NAME}.eep;${NAME}.lst")

        # generate the .hex file
        add_custom_command(
                OUTPUT ${NAME}.hex
                COMMAND ${AVRSTRIP} "${NAME}.elf" -o "${NAME}_stripped.elf"
                COMMAND ${OBJCOPY} -O ihex -j .eeprom --set-section-flags=.eeprom=alloc,load --no-change-warnings --change-section-lma .eeprom=0 "${NAME}_stripped.elf" "${NAME}_stripped.eep"
                COMMAND ${OBJCOPY} -O ihex -R .eeprom "${NAME}_stripped.elf" "${NAME}.hex"
                COMMAND ${AVRSTRIP} "${NAME}.hex"
                COMMAND ${AVRSIZE} --mcu=${MCU} -C --format=avr "${NAME}_stripped.elf"
                DEPENDS ${NAME})
        add_custom_target(${NAME}-strip ALL DEPENDS ${NAME}.hex)

        # add a reset command using avrdude (only if it does not yet exist)
        if (NOT TARGET avr-reset)
            add_custom_target(avr-reset COMMAND ${AVRDUDE} -c${PROGRAMMER} -p${MCU}
            USES_TERMINAL)
        endif ()

        if (PROGRAMMER STREQUAL "usbasp")
            set(AVRDUDE_ARGS -c${PROGRAMMER} -p${MCU} -Pusb)
            add_custom_target(
                ${NAME}-flash
                COMMAND ${AVRDUDE} ${AVRDUDE_ARGS} -v -U flash:w:${NAME}.hex
                DEPENDS ${NAME}.hex
                USES_TERMINAL)
        elseif (PROGRAMMER STREQUAL "atmelice_isp")
        	add_custom_target(
                ${NAME}-flash
                COMMAND avarice -4 -j usb --erase --program --file ${NAME}.hex
                DEPENDS ${NAME}.hex
                USES_TERMINAL)
        else ()
            set(AVRDUDE_ARGS -c${PROGRAMMER} -p${MCU} -P${SERIAL_DEV} -b${BAUD})
            add_custom_target(
                ${NAME}-flash
                COMMAND ${AVRDUDE} ${AVRDUDE_ARGS} -v -U flash:w:${NAME}.hex
                DEPENDS ${NAME}.hex
                USES_TERMINAL)
        endif ()

        # flash the produces binary
       
        add_custom_target(
                ${NAME}-monitor
                COMMAND ${MONITOR} ${MONITOR_ARGS}
                USES_TERMINAL)
                
        add_custom_target(
                ${NAME}-simulate
                COMMAND ${SIMAVR} ${SIMAVR_ARGS} ${NAME}.elf
                USES_TERMINAL
                DEPENDS ${NAME})        
    endif ()
endfunction(add_executable_avr)

# add all the libraries as possible library dependencies
function(add_libraries LIB_PATH)
    set(PROJECT_LIBS)
    file(GLOB LIB_DIRS "${LIB_PATH}/*/CMakeLists.txt")
    foreach (cmakedir ${LIB_DIRS})
        get_filename_component(subdir ${cmakedir} PATH)
        if (IS_DIRECTORY ${subdir})
            get_filename_component(target ${subdir} NAME)
            message(STATUS "Adding ubirch avr library: ${target}")
            add_subdirectory(${subdir})
        endif ()
    endforeach ()
endfunction()

# add targets automatically from the src directory
function(add_sources SRC_PATH)
    file(GLOB SRC_DIRS "${SRC_PATH}/*/CMakeLists.txt")
    foreach (cmakedir ${SRC_DIRS})
        get_filename_component(subdir ${cmakedir} PATH)
        if (IS_DIRECTORY ${subdir})
            get_filename_component(target ${subdir} NAME)
            message(STATUS "Found ubirch avr target: ${target}")
            add_subdirectory(${subdir})
        endif ()
    endforeach ()
endfunction()


# ====================================================================================================================
# ARDUINO SKETCH FUNCTIONALITY
# ====================================================================================================================
# set the arduino sdk path from an environment variable if given
if (DEFINED ENV{ARDUINO_SDK_PATH})
    set(ARDUINO_SDK_PATH "$ENV{ARDUINO_SDK_PATH}" CACHE PATH "Arduino SDK Path" FORCE)
endif ()

set(ARDUINO_CORE_LIBS "" CACHE INTERNAL "arduino core libraries")
function(setup_arduino_core)
    if (DEFINED ARDUINO_SDK_PATH AND IS_DIRECTORY ${ARDUINO_SDK_PATH} AND NOT (TARGET arduino-core))
        # set the paths
        set(ARDUINO_CORES_PATH ${ARDUINO_SDK_PATH}/hardware/arduino/avr/cores/arduino CACHE STRING "")
        set(ARDUINO_VARIANTS_PATH ${ARDUINO_SDK_PATH}/hardware/arduino/avr/variants/standard CACHE STRING "")
        set(ARDUINO_LIBRARIES_PATH ${ARDUINO_SDK_PATH}/hardware/arduino/avr/libraries CACHE STRING "")

        # find arduino-core sources
        file(GLOB_RECURSE CORE_SOURCES ${ARDUINO_CORES_PATH}/*.S ${ARDUINO_CORES_PATH}/*.c ${ARDUINO_CORES_PATH}/*.cpp)

        set(ARDUINO_CORE_SRCS ${CORE_SOURCES} CACHE STRING "Arduino core library sources")

        # setup the main arduino core target
#	    add_library(arduino-core ${ARDUINO_CORE_SRCS})
#        target_include_directories(arduino-core PUBLIC ${ARDUINO_CORES_PATH})
#        target_include_directories(arduino-core PUBLIC ${ARDUINO_VARIANTS_PATH})

        # configure all the additional libraries in the core
        file(GLOB CORE_DIRS ${ARDUINO_LIBRARIES_PATH}/*)
        foreach (libdir ${CORE_DIRS})
            get_filename_component(libname ${libdir} NAME)
            if (IS_DIRECTORY ${libdir})
                file(GLOB_RECURSE sources ${libdir}/*.cpp ${libdir}/*.S ${libdir}/*.c)
                string(REGEX REPLACE "examples?/.*" "" sources "${sources}")
                if (sources)
                    if (NOT TARGET ${libname})
                        message(STATUS "Adding Arduino Core library: ${libname}")
                        add_library(${libname} ${sources})
                    endif ()
                    target_link_libraries(${libname} arduino-core)
                    foreach (src ${sources})
                        get_filename_component(dir ${src} PATH)
                        target_include_directories(${libname} PUBLIC ${dir})
                    endforeach ()
                    list(APPEND ARDUINO_CORE_LIBS ${libname})
                    set(ARDUINO_CORE_LIBS ${ARDUINO_CORE_LIBS} CACHE INTERNAL "arduino core libraries")
                else ()
                    include_directories(SYSTEM ${libdir})
                endif ()
            endif ()
        endforeach ()

        # add some of the default definitions (TODO: identify from Arduino IDE)
        add_definitions(-DARDUINO=10605)
        add_definitions(-DARDUINO_AVR_UNO)
        add_definitions(-DARDUINO_ARCH_AVR)
    endif ()
endfunction()

function(add_sketches SKETCHES_PATH)
    setup_arduino_core()
    if (TARGET arduino-core)
        # finally add all the sketches
        file(GLOB SRC_DIRS "${SKETCHES_PATH}/*/CMakeLists.txt")
        foreach (cmakedir ${SRC_DIRS})
            get_filename_component(subdir ${cmakedir} PATH)
            if (IS_DIRECTORY ${subdir})
                get_filename_component(target ${subdir} NAME)
                message(STATUS "Found Arduino sketch: ${target}")
                add_subdirectory(${subdir})
            endif ()
        endforeach ()
    else ()
        message(WARNING "No Arduino SDK found at '${ARDUINO_SDK_PATH}', can't compile sketches!")
    endif ()
endfunction()

set(SKETCH_LIBS "" CACHE INTERNAL "arduino sketch libraries")
# add a sketch dependency by giving the target and a git url
function(target_sketch_library TARGET NAME URL)
    setup_arduino_core()
    if (TARGET arduino-core AND NOT TARGET ${NAME})
        # try to install dependent libraries
        find_package(Git)
        if (GIT_FOUND)
            # clone dependency into libraries
            get_filename_component(MYLIBS "${CMAKE_CURRENT_SOURCE_DIR}/../libraries" REALPATH)
            if (NOT EXISTS ${MYLIBS})
                message(STATUS "creating library directory: ${MYLIBS}")
                file(MAKE_DIRECTORY ${MYLIBS})
            endif ()
            if (NOT EXISTS ${MYLIBS}/${NAME})
                message(STATUS "Installing ${NAME} (${URL})")
                execute_process(
                        COMMAND ${GIT_EXECUTABLE} clone "${URL}" "${NAME}"
                        WORKING_DIRECTORY ${MYLIBS})
            endif ()

            # now add a library target
            file(GLOB_RECURSE libsources FOLLOW_SYMLINKS ${MYLIBS}/${NAME}/*.S ${MYLIBS}/${NAME}/*.c ${MYLIBS}/${NAME}/*.cpp)
            # go through list of sources and remove the examples
            foreach (file ${libsources})
                STRING(REGEX MATCH "/examples?/|/tests?/" example ${file})
                if (NOT example)
                    list(APPEND sources ${file})
                endif ()
            endforeach ()

            if (sources)
                message(STATUS "Adding external library: ${NAME}")
                add_library(${NAME} ${sources})
                target_link_libraries(${NAME} ${ARDUINO_CORE_LIBS} ${SKETCH_LIBS})
                list(APPEND SKETCH_LIBS ${NAME})
                set(SKETCH_LIBS ${SKETCH_LIBS} CACHE INTERNAL "arduino sketch libraries")
                foreach (src ${sources})
                    get_filename_component(dir ${src} PATH)
                    list(APPEND includes ${dir})
                endforeach ()
                list(REMOVE_DUPLICATES includes)
                target_include_directories(${NAME} PUBLIC ${includes})
                target_link_libraries(${TARGET} ${NAME})
            else ()
                include_directories(SYSTEM ${MYLIBS}/${NAME})
            endif ()
        else ()
            message(FATAL_ERROR "Missing git, please install and try again!")
        endif ()
    else ()
        target_link_libraries(${TARGET} ${NAME})
    endif ()
endfunction(target_sketch_library)
