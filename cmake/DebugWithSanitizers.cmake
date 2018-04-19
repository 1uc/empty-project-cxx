if(${CMAKE_CXX_COMPILER_ID} STREQUAL "Clang")
  message("Setting sanitizer flags for ${CMAKE_CXX_COMPILER_ID}...")

  set(ASAN_FLAGS "-fno-omit-frame-pointer -fsanitize=address")
  set(COVERAGE_FLAGS "-fprofile-instr-generate -fcoverage-mapping")

  set(CMAKE_CXX_FLAGS_DEBUGWITHSANITIZERS
    "${CMAKE_CXX_FLAGS_DEBUG} ${ASAN_FLAGS} ${COVERAGE_FLAGS}" )

  set(CMAKE_LINKER_FLAGS_DEBUGWITHSANITIZERS
    "${CMAKE_STATIC_LINKER_FLAGS_DEBUG} ${ASAN_FLAGS}")
endif()
