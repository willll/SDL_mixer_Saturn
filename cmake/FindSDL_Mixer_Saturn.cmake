message("<FindSDL_Mixer_Saturn.cmake>")

SET(SDL_Mixer_Saturn_SEARCH_PATHS
	$ENV{SATURN_ROOT}/SDL_mixer
)

FIND_PATH(SDL_Mixer_Saturn_INCLUDE_DIR SDL_mixer.h
	HINTS
	$ENV{SATURN_ROOT}
	PATH_SUFFIXES include
	PATHS ${SDL_Mixer_Saturn_SEARCH_PATHS}
)

FIND_LIBRARY(SDL_Saturn_LIBRARY_TEMP
	NAMES SDL_mixer_Saturn
	HINTS
	$ENV{SATURN_ROOT}
	PATH_SUFFIXES lib
	PATHS ${SDL_Mixer_Saturn_SEARCH_PATHS}
)

set(SDL_Saturn_LIBRARIES ${SDL_Mixer_Saturn_LIBRARY}/libsdl.a )
set(SDL_Saturn_INCLUDES ${SDL_Mixer_Saturn_INCLUDE_DIR} )

message("</FindSDL_Mixer_Saturn.cmake>")

INCLUDE(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(SDL_Mixer_Saturn REQUIRED_VARS
																	SDL_Mixer_Saturn_LIBRARY
																	SDL_Mixer_Saturn_INCLUDE_DIR )
