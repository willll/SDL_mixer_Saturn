cmake_minimum_required(VERSION 3.0)

SET(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_VERBOSE_MAKEFILE OFF)

set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")
set(CMAKE_EXE_LINKER_FLAGS "")
set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
set(CMAKE_STATIC_LIBRARY_PREFIX "")

set(SATURN_COMMON $ENV{SATURN_COMMON})
set(SATURN_CMAKE $ENV{SATURN_CMAKE})

set( TARGET_NAME sdl_mixer )
set( TARGET_PATH sdl_mixer )

project( SDL_MIXER VERSION 1.0
                  DESCRIPTION "Sega Saturn SDL MIXER 1.2.7"
                  LANGUAGES C)

set(as_flags )
set(cxx_flags
        -O2 -g3 -m2
        -fpermissive
        -Wno-conversion-null
        -fno-lto -Wshadow -Wall -Wswitch -Wpadded
        -fno-common -Wextra -Wno-narrowing -fno-web
        -fno-builtin -funit-at-a-time -Wwrite-strings
        -Wl,--strip-all -Wl,--verbose -mno-fsrra
        -Wno-padded
        -maccumulate-outgoing-args -fomit-frame-pointer
        -fno-rtti
        -fno-exceptions
         )

set(SOURCES

  music.c
  effects_internal.c
  mixer.c
  load_aiff.c
  )

add_compile_definitions(MODEL_S
                        _SH
                        )

find_package(SDL_Saturn REQUIRED)

#target_link_libraries( ${TARGET_NAME} PUBLIC ${SDL_Saturn_LIBRARIES} )

add_library( ${TARGET_NAME} STATIC
             ${SOURCES} )

target_include_directories(
    ${TARGET_NAME} PUBLIC
    src
    ${SDL_Saturn_INCLUDES}
    )

target_compile_options(sdl_mixer PUBLIC $<$<COMPILE_LANGUAGE:C>:${c_flags}> )

target_link_options(sdl_mixer PUBLIC
    "SHELL:-Xlinker -Map -Xlinker sdl_mixer.map"
    "SHELL:-Xlinker --strip-debug"
    "SHELL:-Xlinker -fno-lto"
    "SHELL:-m2 -nostartfiles"
    "SHELL:-T${SATURN_COMMON}/Saturn.lnk"
    "SHELL:-lc -lgcc -lm"
)

set_target_properties(${TARGET_NAME} PROPERTIES PREFIX "")

install(TARGETS ${TARGET_NAME} DESTINATION lib)
