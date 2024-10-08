set(HIP_KERNEL_SRC kernel.hip)

add_library(hip_kernels_obj OBJECT ${HIP_KERNEL_SRC})

target_include_directories(hip_kernels_obj PRIVATE ${CMAKE_SOURCE_DIR}/include)

