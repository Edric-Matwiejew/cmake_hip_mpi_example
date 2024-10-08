# Enable Fortran, doing it here as the Fortran component is optional.
enable_language(Fortran)

# Set is output path for Fortran *.mod files.
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/include)

set(F90_SRC_FILES test_lib.f90)

add_library(test_lib_f90 SHARED ${F90_SRC_FILES})

target_link_libraries(test_lib_f90 PRIVATE test_lib hip::host MPI::MPI_CXX)

install(TARGETS test_lib_f90 LIBRARY DESTINATION lib)
# Ensure that the Fortran library *.mod is installed.
install(DIRECTORY ${CMAKE_Fortran_MODULE_DIRECTORY}/ DESTINATION include
        FILES_MATCHING PATTERN "*.mod")

