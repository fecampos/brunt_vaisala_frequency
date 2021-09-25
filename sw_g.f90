      subroutine sw_g(ny,nz,Y,Z,g)

      implicit none

      integer, intent(in) :: ny, nz

      real, intent(in) :: Y(ny), Z(nz)

      real, intent(out) :: g(ny,nz)

      real, parameter  :: a = 6371000, pi = 3.1415927

      integer :: i, j, k

      real :: X(ny), sin2(ny), g1(ny)

      X = sin(abs(Y)*pi/180)

      sin2 = X*X

      g1 = 9.780318*(1.0+(5.2788E-3+2.36E-5*sin2)*sin2)
      
      !$OMP PARALLEL DO      
      do k = 1,nz
        do j = 1,ny
          g(j,k) = g1(j)/((1+Z(j)/a)**2)
        end do
      end do
      !$OMP END PARALLEL DO

      end subroutine
