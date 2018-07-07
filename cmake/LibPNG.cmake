#LibPNG.cmake 
set(NAME "png")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(PATH_LIBPNG 	"${CMAKE_BINARY_DIR}/libpng"
	CACHE STRING	"${CMAKE_BINARY_DIR}/libpng")
#message("PATH_LIBPNG = ${PATH_LIBPNG}")
set(PNG_TESTS OFF)

set(FTP_LIBPNG "ftp://ftp-osl.osuosl.org/pub/libpng/src")
set(URL_LIBPNG "${FTP_LIBPNG}/libpng16/libpng-1.6.34.tar.gz")

if(NOT IS_DIRECTORY ${PATH_LIBPNG})
message("--- Downloading " ${NAME} " ---")
	download_project(PROJ libpng
	PREFIX ${PATH_LIBPNG}
	URL ${URL_LIBPNG}
	UPDATE_DISCONNECTED ON
)
endif()

add_subdirectory("${PATH_LIBPNG}/libpng-src" "${PATH_LIBPNG}/libpng-build")

set(PNG_BUILD_ZLIB TRUE CACHE BOOL TRUE)
set(NAME libpng)
set(PNG_LIB_OPT "${PATH_LIBPNG}/${NAME}-build/Release/${NAME}16_staticd.lib")
set(PNG_LIB_DEBUG "${PATH_LIBPNG}/${NAME}-build/Debug/${NAME}16_staticd.lib")	
set(PNG_LIBRARIES ${PNG_LIB_DEBUG} CACHE STRING ${PNG_LIB_DEBUG})
# ./libpng/libpng-build/pnglibconf.h
set(PNG_INCLUDE_DIR "${PATH_LIBPNG}/libpng-build" "${PATH_LIBPNG}/libpng-src")
set(PNG_INCLUDE_DIRS ${PNG_INCLUDE_DIR} CACHE STRING ${PNG_INCLUDE_DIR})
message("PNG_INCLUDE_DIRS = ${PNG_INCLUDE_DIRS}")
set(PNG_FOUND TRUE CACHE BOOL TRUE)
set(PNG_VERSION_STRING "CinePaint" CACHE STRING "CinePaint")
set(HAVE_LIBPNG_PNG_H TRUE CACHE BOOL TRUE)
set(PNG_TESTS FALSE CACHE BOOL FALSE)

#message("--- Patching ${NAME} ---")
#set(SUB "s/CACHE//")
#set(PATCH_FILE 
#	"libpng-build/CMakeFiles/Export/lib/libpng/libpng16.cmake")
#execute_process(
#	COMMAND sed ${SUB} ${PATCH_FILE} -i	
#	COMMAND touch ${NAME}-patch
#		WORKING_DIRECTORY ${PATH_LIBPNG})
