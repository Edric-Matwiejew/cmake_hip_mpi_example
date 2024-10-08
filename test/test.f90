program call_test_lib
  use mpi
  use test_lib
  implicit none

  integer :: mpi_rank, mpi_size, device_count, ierr

  call MPI_Init(ierr)

  call MPI_Comm_rank(MPI_COMM_WORLD, mpi_rank, ierr)
  call MPI_Comm_size(MPI_COMM_WORLD, mpi_size, ierr)

  ! Need to use hipFORT for hipGetDeviceCount, for now just setting
  ! the device count to one.
  device_count = 1

  call test(mpi_rank, device_count)

  call MPI_Finalize(ierr)

end program call_test_lib

