#ZLIB.cmake
set(NAME "zlib")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(LIB_PATH "${SOURCE_BUILDER_DIR}/${NAME}")
set(URL "http://zlib.net/zlib-1.2.11.tar.gz")
message("LIB_PATH = ${LIB_PATH}")

if(NOT IS_DIRECTORY ${LIB_PATH})
	download_project(PROJ ${NAME}
	PREFIX ${LIB_PATH}
	URL ${URL}
	UPDATE_DISCONNECTED ON
)
endif()

set(ZLIB_ROOT ${LIB_PATH} 
	CACHE STRING ${LIB_PATH})

set(ZLIB_INCLUDE_DIRS "${LIB_PATH}/${NAME}-build" "${LIB_PATH}/${NAME}-src")

set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS} 
	CACHE STRING ${ZLIB_INCLUDE_DIRS})

include_directories(${ZLIB_INCLUDE_DIRS})
#message("ZLIB_INCLUDE_DIR = ${ZLIB_INCLUDE_DIR}")

add_subdirectory("${LIB_PATH}/${NAME}-src" "${LIB_PATH}/${NAME}-build")

set(ZLIB_FOUND TRUE CACHE BOOL TRUE)
set(ZLIB_LIB_OPT "${LIB_PATH}/${NAME}-build/Release/${NAME}staticd.lib")
set(ZLIB_LIB_DEBUG "${LIB_PATH}/${NAME}-build/Debug/${NAME}staticd.lib")

set(ZLIB_LIB_OPT ${ZLIB_LIB_OPT} CACHE STRING ${ZLIB_LIB_OPT})
set(ZLIB_LIB_DEBUG ${ZLIB_LIB_DEBUG} CACHE STRING ${ZLIB_LIB_DEBUG})
set(ZLIB_LIBRARY ${ZLIB_LIB_DEBUG} CACHE STRING ${ZLIB_LIB_DEBUG})
set(ZLIB_LIBRARIES ${ZLIB_LIB_DEBUG} CACHE STRING ${ZLIB_LIB_DEBUG})

#message("${NAME} = ${ZLIB_LIBRARY}")
find_package(ZLIB REQUIRED )