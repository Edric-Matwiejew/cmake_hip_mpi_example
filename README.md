This is an example project that demonstrates the building of a C++ library and Fortran interface library that utilises HIP, HIP libraries and MPI.

The library `test_lib` contains a single function `test` that depends on MPI, HIP, and hipFFT. 

To set up the environment and `LD_LIBRARY_PATH` source `env.sh`.

To build the library and tests, run `build_script.sh`. The library and tests will be installed in the project root. 
