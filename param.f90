      module param

      implicit none

      character(len=*),parameter :: file_in = "in.nc"
     
      character(len=*),parameter :: t_NAME = "time"
      character(len=*),parameter :: x_NAME = "longitude"
      character(len=*),parameter :: y_NAME = "latitude"
      character(len=*),parameter :: z_NAME = "depth"

      character(len=*),parameter :: xi_NAME = "rhopoto"

      integer, parameter :: nx = 1321, ny = 481, nz = 50, nt = 1

      integer :: i, j, k

      real, parameter :: pi = 3.1415927

      real, parameter :: missing_val = -32767, sf_sla = 1, af_sla = 0

      real :: T(nt), X(nx), Y(ny), Z(nz), g(ny,nz), xi(nx,ny,nz), n2(nx,ny,nz-1)

      integer :: ncid, retval, tvarid, xvarid, yvarid, zvarid, xivarid

      end module
