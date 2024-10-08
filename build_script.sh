module load cmake/3.27.7
module load cray-mpich 
module load rocm
module load gcc

rm -rf build lib include bin

cmake -B build -S . -DCMAKE_INSTALL_PREFIX=$PWD -DBUILD_FORTRAN=1
cmake --build build --target install

#cd test && rm -rf build
#
#cmake -B build -S . -DCMAKE_INSTALL_PREFIX=$PWD/.. -DBUILD_FORTRAN=1 -DTEST_LIB_PATH=$PWD/..
#cmake --build build --target install
#
#export LD_LIBRARY_PATH=$PWD/../lib:$LD_LIBRARY_PATH
#
#./bin/hip_mpi_program_cpp  
#./bin/hip_mpi_program_f90

