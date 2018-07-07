#LibJPEG.cmake
set(NAME "turbojpeg")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(CMAKE_BUILD_TYPE Release)
#set(GIT_REPO https://github.com/mozilla/mozjpeg.git)
set(GIT_REPO https://github.com/libjpeg-turbo/libjpeg-turbo.git)
set(GIT_TAG master)

set(PATH_JPEG "${CMAKE_BINARY_DIR}/${NAME}")
set(PATH_LIBJPEG ${PATH_JPEG} CACHE STRING ${PATH_JPEG})

if(NOT IS_DIRECTORY ${PATH_LIBJPEG})
download_project(PROJ libjpeg
	PREFIX              ${PATH_LIBJPEG}
#	GIT_REPOSITORY ${GIT_REPO}     
	GIT_REPOSITORY ${GIT_REPO}     
	GIT_TAG        ${GIT_TAG}
	UPDATE_DISCONNECTED ON
)
endif()

#../build/libjpeg86/libjpeg-build/jconfig.h
include_directories(
	${libjpeg_SOURCE_DIR}
	${libjpeg_BINARY_DIR})

set(WITH_12BIT TRUE)
set(WITH_SIMD FALSE CACHE BOOL FALSE)
set(WITH_ARITH_ENC TRUE)
set(WITH_ARITH_DEC TRUE)
set(ENABLE_STATIC TRUE)
set(JPEG_FOUND TRUE)
set(JPEG_INCLUDE_DIR "${libjpeg_SOURCE_DIR}")

if(NOT EXISTS ${PATH_LIBJPEG}/${NAME}-patch)
	message("--- Patching ${NAME} ---")
#	set(PATCH_CMP0022 "s/cmake_policy\\(SET\\ CMP0022/#cmake_policy(SET\\ CMP0022/")
	set(PATCH_CMP0022 "s/\\(cmake_policy(SET CMP0022\\)/#\\1/") 
#	message(${PATCH_CMP0022})
	set(PATCH_CURRENT "s/CMAKE_SOURCE_DIR/CMAKE_CURRENT_SOURCE_DIR/g")
	set(PATCH_CURRENT_UP "s|CMAKE_SOURCE_DIR}|CMAKE_CURRENT_SOURCE_DIR}/..|g")
	set(PATCH_INTERFACE "s/INTERFACE_LINK_LIBRARIES/LINK_INTERFACE_LIBRARIES/g")
	set(FILE_CMakeLists "libjpeg-src/CMakeLists.txt")
	set(FILE_sharedlib "libjpeg-src/sharedlib/CMakeLists.txt")
	execute_process(
		COMMAND sed ${PATCH_CMP0022} ${FILE_CMakeLists} -i
		COMMAND sed ${PATCH_CURRENT} ${FILE_CMakeLists} -i
		COMMAND sed ${PATCH_INTERFACE} ${FILE_CMakeLists} -i
		COMMAND sed ${PATCH_CURRENT_UP} ${FILE_sharedlib} -i
		COMMAND touch ${NAME}-patch
		WORKING_DIRECTORY ${PATH_LIBJPEG})
endif()

add_subdirectory("${PATH_LIBJPEG}/libjpeg-src" "${PATH_LIBJPEG}/libjpeg-build")

set(JPEG_LIB_OPT "${PATH_LIBJPEG}/libjpeg-build/Release/${NAME}.lib")
set(JPEG_LIB_DEBUG "${PATH_LIBJPEG}/libjpeg-build/Debug/${NAME}.lib")

set(JPEG_LIBRARIES ${JPEG_LIB_DEBUG} CACHE STRING ${JPEG_LIB_DEBUG})
set(JPEG_INCLUDE_DIR 
	${PATH_LIBJPEG}/libjpeg-build
	${PATH_LIBJPEG}/libjpeg-src)
set(JPEG_INCLUDE_DIR ${JPEG_INCLUDE_DIR} CACHE STRING ${JPEG_INCLUDE_DIR})
set(JPEG_FOUND TRUE CACHE BOOL TRUE)
set(JPEG_LIB_VERSION 80 CACHE STRING 80)
