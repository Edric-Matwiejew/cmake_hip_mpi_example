#ifndef KERNEL_H
#define KERNEL_H

#include <hip/hip_runtime.h>
#include <iostream>
#include <stdexcept>
#include <stdio.h>

#define hipCheck(stmt)                                                         \
  {                                                                            \
    hipError_t err = stmt;                                                     \
    if (err != hipSuccess) {                                                   \
      fprintf(stderr, "Failed to run %s\n%s (%d) at %s: %d\n", #stmt,          \
              hipGetErrorString(err), err, __FILE__, __LINE__);                \
      throw std::invalid_argument("hipCheck failed");                          \
    }                                                                          \
  }

void hip_func();

#endif // KERNEL_H

