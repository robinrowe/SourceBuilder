#Openexr.cmake

set(NAME "ilmbase")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(PATH_ILMBASE "${CMAKE_BINARY_DIR}/ilmbase")
set(URL_ILMBASE "http://download.savannah.nongnu.org/releases/openexr/ilmbase-2.2.1.tar.gz")
set(PATH_OPENEXR "${CMAKE_BINARY_DIR}/openexr")
set(URL_OPENEXR "http://download.savannah.nongnu.org/releases/openexr/openexr-2.2.1.tar.gz")

if(WIN32)
message("Setting EXR Win32 flags...")
# warning C4275: non dll-interface class 
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4275" ) 
# warning C4996: 'getenv'
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4996" )
# warning C4251: class needs to have dll-interface 
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4251" )
# warning C4018: '<': signed/unsigned mismatch
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4018" )
# warning C4244: 'argument': conversion from 'time_t' to 'unsigned long'
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4244" )
# warning C4267: 'argument': conversion from 'size_t' to 'unsigned short', possible loss of data
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4267" )
# warning C4305: 'initializing': truncation from 'double' to 'float'
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4305" )
# warning C4099: type name first seen using 'struct' now seen using 'class'
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4099" )
# warning C4101: unreferenced local variable
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4101" )
# warning C4715: not all control paths return a value
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4715" )
# warning C4309: 'argument': truncation of constant value
	set( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} /wd4309" )
endif()

link_directories(
	${PATH_ILMBASE}/libbase-build/Iex/Debug 
	${PATH_ILMBASE}/libbase-build/IlmThread/Debug 
	${PATH_ILMBASE}/libbase-build/Imath/Debug )

set(PATH_EXR ${CMAKE_BINARY_DIR}/ilmbase/ilmbase-src PARENT_SCOPE)

set(ILM_CONFIG ${CMAKE_BINARY_DIR}/ilmbase/libbase-build/config )
#message ("ILM_CONFIG = ${ILM_CONFIG}")
	
include_directories(
	${PATH_EXR}
	${ILM_CONFIG}
	${PATH_EXR}/Half
	${PATH_EXR}/IlmThread
	${PATH_EXR}/Imath
	${PATH_EXR}/Iex )
#	${PATH_OPENEXR}/openexr-src)

#get_property(inc_dirs DIRECTORY PROPERTY INCLUDE_DIRECTORIES)
#message("ilm_inc_dirs = ${inc_dirs}")	
	
#get_property(ILM_LINK_DIRS DIRECTORY PROPERTY LINK_DIRECTORIES)
#message("ILM_LINK_DIRS = ${ILM_LINK_DIRS}")

#message("ZLIB_INCLUDE_DIR = ${ZLIB_INCLUDE_DIR}")

if(NOT IS_DIRECTORY ${PATH_ILMBASE})
	download_project(PROJ ilmbase
		PREFIX ${PATH_ILMBASE}
		URL ${URL_ILMBASE}
		UPDATE_DISCONNECTED ON
	)
endif()

add_subdirectory("${PATH_ILMBASE}/ilmbase-src" "${PATH_ILMBASE}/libbase-build")

set(NAME "openexr")
project(${NAME})
message("--- Building " ${NAME} " ---")

link_directories(
	${PATH_OPENEXR}/openexr-build/IlmImf/Debug )

if(NOT IS_DIRECTORY ${PATH_OPENEXR})
	download_project(PROJ openexr
		PREFIX ${PATH_OPENEXR}
		URL ${URL_OPENEXR}
		UPDATE_DISCONNECTED ON
	)
endif()

add_subdirectory("${PATH_OPENEXR}/openexr-src" "${PATH_OPENEXR}/openexr-build")
