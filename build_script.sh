. env.sh

rm -rf build lib include bin

cmake -B build -S . -DCMAKE_INSTALL_PREFIX=$PWD -DBUILD_FORTRAN=1
cmake --build build --target install

cd test && rm -rf build

cmake -B build -S . -DCMAKE_INSTALL_PREFIX=$PWD/.. -DBUILD_FORTRAN=1 -DTEST_LIB_PATH=$PWD/..
cmake --build build --target install
