#CinePaint FLTK.cmake
set(NAME "fltk")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(URL_FLTK "http://fltk.org/pub/fltk/snapshots/fltk-1.4.x-r12602.tar.gz")
set(GIT_FLTK "https://github.com/fltk/test-only.git")
set(GIT_TAG "branch-1.4")

set(PATH_FLTK "${CMAKE_BINARY_DIR}/fltk" CACHE STRING "${CMAKE_BINARY_DIR}/fltk" )

if(WIN32)
add_definitions(-DWIN32)
endif()

set(OPTION_BUILD_EXAMPLES FALSE CACHE BOOL FALSE)
#set(CMAKE_INCLUDE_PATH /Code/github/vcpkg/installed/x86-windows/include)
set(OPTION_USE_SYSTEM_LIBPNG ON CACHE BOOL ON)
set(OPTION_USE_SYSTEM_LIBJPEG ON CACHE BOOL ON)
set(HAVE_PNG_H TRUE CACHE BOOL TRUE)
# (cmake) -D"OPTION_BUILD_EXAMPLES:BOOL=OFF"
# ./libpng/libpng-build/pnglibconf.h
# ./libjpeg86/libjpeg-build/jconfig.h

include_directories(
	${PNG_INCLUDE_DIR}
	${JPEG_INCLUDE_DIR}
	)

#./libjpeg86/libjpeg-build/Debug/jpeg-static.lib
#./libjpeg86/libjpeg-build/sharedlib/Debug/jpeg.lib
#./zlib/zlib-build/Debug/zlibstaticd.lib

#link_directories(
#	${PATH_LIBJPEG}/libjpeg-build/Debug
#	${PATH_LIBPNG}/libpng-build/Debug 
#	${PATH_ZLIB}/zlib-build/Debug 
#	)

if(NOT IS_DIRECTORY ${PATH_FLTK})
message("--- Downloading ${NAME} ---")
download_project(PROJ ${NAME}
	PREFIX              ${PATH_FLTK}
	GIT_REPOSITORY      ${GIT_FLTK}
	GIT_TAG             ${GIT_TAG}
	UPDATE_DISCONNECTED ON
)
endif()

if(NOT EXISTS ${PATH_FLTK}/${NAME}-patch)
	message("--- Patching ${NAME} ---")
	set(PATCH_REGEX "s/add_custom_target\\(uninstall/add_custom_target\\(uninstall-${NAME}/")
	set(PATCH_FILE "${NAME}-src/CMake/install.cmake")
	execute_process(
		COMMAND sed ${PATCH_REGEX} ${PATCH_FILE} -i
		COMMAND touch ${NAME}-patch
		WORKING_DIRECTORY ${PATH_FLTK})
endif()

add_subdirectory("${PATH_FLTK}/${NAME}-src" "${PATH_FLTK}/${NAME}-build")

set(FLTK_LIB_OPT "${PATH_FLTK}/${NAME}-build/lib/Release/${NAME}d.lib")
set(FLTK_LIB_DEBUG "${PATH_FLTK}/${NAME}-build/lib/Debug/${NAME}d.lib")	
set(FLTK_LIBRARY ${FLTK_LIB_DEBUG} CACHE STRING ${FLTK_LIB_DEBUG})
set(FLTK_IMAGE_LIB_OPT "${PATH_FLTK}/${NAME}-build/lib/Release/${NAME}_imagesd.lib")
set(FLTK_IMAGE_LIB_DEBUG "${PATH_FLTK}/${NAME}-build/lib/Debug/${NAME}_imagesd.lib")
set(FLTK_IMAGE_LIBRARY ${FLTK_IMAGE_LIB_DEBUG} CACHE STRING ${FLTK_IMAGE_LIB_DEBUG})
#message("FLTK_IMAGE = ${FLTK_IMAGE_LIBRARY}")
	

