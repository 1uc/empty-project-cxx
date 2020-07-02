add_library(warning_flags INTERFACE)
if(CMAKE_CXX_COMPILER_ID STREQUAL "clang")
  target_compile_options(warning_flags INTERFACE -Wall)
  target_compile_options(warning_flags INTERFACE -Wextra)
  target_compile_options(warning_flags INTERFACE -Wconversion)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  target_compile_options(warning_flags INTERFACE -Wall)
  target_compile_options(warning_flags INTERFACE -Wextra)
  target_compile_options(warning_flags INTERFACE -Wconversion)
else()
  message("Maybe implement the warning flags for your compiler.")
endif()
