# SourceBuilder/CmakeLists.txt
cmake_minimum_required(VERSION 3.10)

set(NAME "SourceBuilder")
project(${NAME})
message("--- ${NAME} ---")

set(SOURCE_BUILDER_DIR "${CMAKE_CURRENT_BINARY_DIR}") 
message("SOURCE_BUILDER_DIR = \"${SOURCE_BUILDER_DIR}\"")

add_subdirectory(CinePaint)
#add_subdirectory(EOS)
#add_subdirectory(Iroha)
