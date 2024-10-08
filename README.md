This is an example project that demonstrates the building of a C++ library and Fortran interface library that utilises HIP, HIP libraries and MPI.

The `build.sh` script builds the library, installs it to the project root and builds tests. The test binaries are installed to `bin` in the project root.

The library `test_lib` contains a single function `test` that is dependent on MPI, HIP, and hipFFT. 

