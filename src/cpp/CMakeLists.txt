add_subdirectory(${CMAKE_SOURCE_DIR}/src/hip ${CMAKE_BINARY_DIR}/hip)

set(CPP_SRC_FILES test_lib.cpp)

add_library(test_lib SHARED ${CPP_SRC_FILES})

target_link_libraries(test_lib PRIVATE hip_kernels_obj hip::host MPI::MPI_CXX hip::hipfft)

target_include_directories(test_lib PRIVATE ${CMAKE_SOURCE_DIR}/src/hip)

install(TARGETS test_lib LIBRARY DESTINATION lib)
install(FILES test_lib.h DESTINATION include)
