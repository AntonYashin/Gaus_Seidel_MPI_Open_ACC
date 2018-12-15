!  MPI_fortran.f90 
!
!  FUNCTIONS:
!  MPI_fortran - Entry point of console application.
!

!****************************************************************************
!
!  PROGRAM: MPI_fortran
!
!  PURPOSE:  Entry point for the console application.
!
!****************************************************************************

    program MPI_fortran

        include 'mpif.h'

        integer, parameter :: size = 4
        integer :: ierr, rank, num_procs
        real, dimension(size, size) :: sendbuf
        real, dimension(size*2) :: recvbuf
        integer :: j
        
        call MPI_INIT ( ierr )
      
        call MPI_COMM_RANK (MPI_COMM_WORLD, rank, ierr)
        call MPI_COMM_SIZE (MPI_COMM_WORLD, num_procs, ierr)
        
      
       
        if (rank .eq. 0) then
            sendbuf = reshape((/1.0, 2.0, 3.0, 4.0, &
                               5.0, 6.0, 7.0, 8.0,&
                               9.0, 10.0, 11.0, 12.0, &
                               13.0, 14.0, 15.0, 16.0 /), (/size, size/))    
            print *, "sssssssssssssssssssss", sendbuf(1,3)
            j = j + 1
        endif
        
        call MPI_Scatter(sendbuf, size*2, MPI_REAL, recvbuf, size*2, MPI_REAL, 0, MPI_COMM_WORLD, ierr)
        do j = 1, size*2
            print *, "my_id: ", rank, ", data: ", recvbuf(j), ", j: ", j
        end do
        
        call MPI_FINALIZE(ierr)
    end program MPI_fortran

