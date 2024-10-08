module test_lib
  use iso_c_binding, only: c_int

  interface
    subroutine test(mpi_rank, device_count) &
                bind(C, name = "test")
      import :: c_int
      integer(c_int), value :: mpi_rank
      integer(c_int), value :: device_count
    end subroutine test
  end interface

end module test_lib

