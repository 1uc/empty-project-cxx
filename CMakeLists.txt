cmake_minimum_required(VERSION 3.0)

include("cmake/HunterGate.cmake")
include("cmake/FastDebug.cmake")
include("cmake/ASAN.cmake")

HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.22.14.tar.gz"
    SHA1 "f194eab02248f7d8792f7fc0158f6194d005bf86"
)

project(PROJECT_NAME)

# -- Dependencies --------------------------------------------------------------
add_library(third_party INTERFACE)

hunter_add_package(Boost COMPONENTS program_options)
find_package(Boost CONFIG REQUIRED program_options)
target_link_libraries(third_party INTERFACE Boost::program_options)

hunter_add_package(nlohmann_json)
find_package(nlohmann_json CONFIG REQUIRED)
target_link_libraries(third_party INTERFACE nlohmann_json)

# -- Flags ---------------------------------------------------------------------
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG(-Wall COMPILER_SUPPORTS_WALL)
CHECK_CXX_COMPILER_FLAG(-Wextra COMPILER_SUPPORTS_WEXTRA)
CHECK_CXX_COMPILER_FLAG(-Wconversion COMPILER_SUPPORTS_WCONVERSION)

add_library(warning_flags INTERFACE)
if(COMPILER_SUPPORTS_WALL)
  target_compile_options(warning_flags INTERFACE -Wall)
endif()
if(COMPILER_SUPPORTS_WEXTRA)
  target_compile_options(warning_flags INTERFACE -Wextra)
endif()
if(COMPILER_SUPPORTS_WCONVERSION)
  target_compile_options(warning_flags INTERFACE -Wconversion)
endif()

# -- Tests ---------------------------------------------------------------------
hunter_add_package(Catch)
find_package(Catch2 CONFIG REQUIRED)

add_executable(unit_tests "")
set_target_properties(unit_tests PROPERTIES CXX_STANDARD 17)
target_link_libraries(unit_tests PUBLIC Catch2::Catch third_party)

enable_testing()
add_test(NAME UnitTests COMMAND unit_tests)

# -- Subdirectories ------------------------------------------------------------
add_subdirectory(test)
# add_subdirectory(src)
