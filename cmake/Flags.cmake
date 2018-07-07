
#set(PNG_BUILD_ZLIB ON PARENT_SCOPE)
set(PNG_BUILD_ZLIB ON CACHE BOOL ON FORCE)
message("PNG_BUILD_ZLIB = ${PNG_BUILD_ZLIB}")


#message("CMAKE BUILD TYPE = ${CMAKE_BUILD_TYPE}")

#target_link_libraries(your-app ... ${LIBZ_LIB}

if(0)
set(ZLIB_INCLUDE_DIR "${CMAKE_BINARY_DIR}/zlib/zlib-src")
set(ZLIB_ROOT "${CMAKE_BINARY_DIR}/zlib")
set(ZLIB_DIR "${CMAKE_BINARY_DIR}/zlib")

find_package( ZLIB REQUIRED )
#if ( ZLIB_FOUND )
    include_directories( ${ZLIB_INCLUDE_DIRS} )
#    target_link_libraries( YourProject ${ZLIB_LIBRARIES} )
#endif( ZLIB_FOUND )
message("find zlib = ${PATH_ZLIB}")
set(ZLIB_DIR "${CMAKE_BINARY_DIR}/zlib")
find_package(ZLIB PATHS ${PATH_ZLIB} NO_DEFAULT_PATH)
set(ZLIB_FOUND TRUE)
#set(ZLIB_LIBRARY "${PATH_ZLIB}/bin")
#set(ZLIB_INCLUDE_DIR "${PATH_ZLIB}/zlib-src")
#ZLIB_INCLUDE_DIR=....\include 
#ZLIB_LIBRARY=..\lib\lib
endif()
#find_package(ZLIB PATHS ${PATH_ZLIB} NO_MODULE)
#if(ZLIB_FOUND)
SET(LIBZ_LIB optimized ${PROJECT_SOURCE_DIR}/zlib.lib
             debug ${PROJECT_SOURCE_DIR}/zlibd.lib)
#set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS})
#set(ZLIB_LIB_PATH "${PATH_ZLIB}/zlib-src" "${PATH_ZLIB}/zlib-build")
#set(ZLIB_LIBRARIES "${ZLIB_LIB_PATH}/zlib")

#include_directories(${ZLIB_INCLUDE_DIR})

#set(ZLIB_INCLUDE_DIR "${PATH_ZLIB}/zlib-src")
include_directories(${ZLIB_ROOT}/zlib-build ${ZLIB_ROOT}/zlib-src)
message("zlib inc = ${ZLIB_ROOT}")
#link_directories("${PATH_ILMBASE}/libbase-build/Iex/Debug")
# 9>LINK : fatal error LNK1104: cannot open file 'Iex-2_2.lib'
add_subdirectory("${PATH_ILMBASE}/ilmbase-src" "${PATH_ILMBASE}/ilmbase-build")

#add_subdirectory(${zlib_SOURCE_DIR})
#add_subdirectory(dependencies/zlib "${CMAKE_CURRENT_BINARY_DIR}/zlib_build")
#add_dependencies(${PROJECT_NAME} zlibstatic)
#target_link_libraries(${PROJECT_NAME} zlibstatic)

#target_link_libraries(png ${LIBZ_LIB})

#set(PNG_FOUND TRUE)
#set(PNG_INCLUDE_DIR "${libpng_SOURCE_DIR}" "${PATH_ZLIB}/zlib-src")
#message("libpng = ${PNG_INCLUDE_DIR}")
#libpng = C:/Code/gitlab/Cinepaint/glasgow/lib


# "${PATH_ZLIB}/zlib-build" "${PATH_ZLIB}/zlib-src")
#set(PNG_LIBRARIES "${PATH_ZLIB}/zlib-src" "${PATH_ZLIB}/zlib-build")
#set(PNG_LIBRARY "${PATH_ZLIB}/bin")

include_directories(${zlib_BUILD_DIR} ${zlib_SOURCE_DIR})
set(ZLIB_INCLUDE_DIRS ${zlib_BUILD_DIR} ${zlib_SOURCE_DIR})
set(ZLIB_INCLUDE_DIR ${ZLIB_INCLUDE_DIRS})
add_subdirectory("${PATH_LIBPNG}/libpng-src" "${PATH_LIBPNG}/libpng-build")

project(${NAME} C ASM)
enable_language( C ASM )

#include_directories(${PNG_INCLUDE_DIR})
# ./zlib/zlib-src/zlib.h
#add_subdirectory(${zlib_SOURCE_DIR} ${zlib_BUILD_DIR})
#add_subdirectory(${ZLIB_LIB_PATH})
#set(ZLIB_INCLUDE_DIR "${zlib_SOURCE_DIR}")
