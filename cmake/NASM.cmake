#NASM.cmake
set(NAME "NASM")
project(${NAME})
message("--- Building " ${NAME} " ---")

set(PATH_LIB "${CMAKE_BINARY_DIR}/${NAME}")
set(GIT_REPO http://repo.or.cz/nasm.git)
set(GIT_BRANCH master)

if(NOT IS_DIRECTORY ${PATH_LIB})
	download_project(PROJ ${NAME}
	PREFIX ${PATH_LIB}
	GIT_REPOSITORY      ${GIT_REPO}
	GIT_TAG             ${GIT_BRACH}
	UPDATE_DISCONNECTED ON
)
endif()

add_subdirectory("${PATH_LIB}/${NAME}-src" "${PATH_LIB}/${NAME}-build")

