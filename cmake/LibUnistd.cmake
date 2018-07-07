set(NAME "libunistd")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(GIT_REPO https://github.com/robinrowe/libunistd.git)
set(GIT_TAG master)
set(PATH_LIBUNISTD 	"${CMAKE_BINARY_DIR}/${NAME}" 
	CACHE STRING 	"${CMAKE_BINARY_DIR}/${NAME}")

IF (WIN32)
#	message("Windows DEFINE = _CRT_SECURE_NO_WARNINGS")
	include_directories(SYSTEM "${unistd_SOURCE_DIR}/vcpp")
	add_definitions(-DLWS_NO_FORK)
	add_definitions(-D_CRT_SECURE_NO_WARNINGS)
	add_definitions(-D_CRT_NONSTDC_NO_WARNINGS)
	# warning C4996: Call with parameters that may be unsafe 
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4996" ) 
	# warning C4244: possible loss of data
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4244" ) 
	# warning C4800: 'int': forcing value to bool 'true' or 'false' (performance warning)
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4800" ) 
	# warning C4805: unsafe mix of type 'bool' in operation
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4805" ) 
	# warning C4267: possible loss of data
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4267" ) 
	#  warning C4804: '>': unsafe use of type 'bool' in operation
	SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4804" ) 
ENDIF()

if(NOT IS_DIRECTORY ${PATH_LIBUNISTD})
download_project(PROJ libunistd
	PREFIX              ${PATH_LIBUNISTD}
	GIT_REPOSITORY      ${GIT_REPO}
	GIT_TAG             ${GIT_TAG}
	UPDATE_DISCONNECTED ON
)
endif()

add_subdirectory("${PATH_LIBUNISTD}/${NAME}-src" "${PATH_LIBUNISTD}/${NAME}-build")

set(UNISTD_LIB 
	optimized 	${PATH_LIBUNISTD}/${NAME}-build/Release/${NAME}staticd.lib
	debug 		${PATH_LIBUNISTD}/${NAME}-build/Debug/${NAME}staticd.lib
)	
set(UNISTD_LIBRARIES ${UNISTD_LIB} CACHE STRING ${UNISTD_LIB})
set(UNISTD_INCLUDE_DIR ${PATH_LIBPNG}/libunistd-src)
set(UNISTD_INCLUDE_DIRS ${UNISTD_INCLUDE_DIR} CACHE STRING ${UNISTD_INCLUDE_DIR})
set(UNISTD_FOUND TRUE CACHE BOOL TRUE)
