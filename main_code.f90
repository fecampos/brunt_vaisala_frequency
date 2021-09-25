      program main_code

      use netcdf

      use param

      implicit none

      retval = nf90_open(file_in, NF90_NOWRITE, ncid)

      retval = nf90_inq_varid(ncid, t_NAME, tvarid)
      retval = nf90_inq_varid(ncid, x_NAME, xvarid)
      retval = nf90_inq_varid(ncid, y_NAME, yvarid)
      retval = nf90_inq_varid(ncid, z_NAME, zvarid)

      retval = nf90_get_var(ncid, tvarid, T)
      retval = nf90_get_var(ncid, xvarid, X)
      retval = nf90_get_var(ncid, yvarid, Y)
      retval = nf90_get_var(ncid, zvarid, Z)

      retval = nf90_inq_varid(ncid, xi_NAME, xivarid)

      retval = nf90_get_var(ncid, xivarid, xi)

      retval = nf90_close(ncid)   

      where(xi.ne.missing_val) 
        xi = xi*sf_sla+af_sla
      end where    

      n2 = missing_val

      call sw_g(ny,nz,Y,Z,g)

      !$OMP PARALLEL DO
      do k = 1,nz-1
        do j = 1,ny
          do i = 1,nx
            if ((xi(i,j,k).ne.missing_val).and.(xi(i,j,k+1).ne.missing_val)) then
               n2(i,j,k) = -(0.5*(g(j,k)+g(j,k+1))*(xi(i,j,k)-xi(i,j,k+1)))/ &
                    ((z(k+1)-z(k))*0.5*(xi(i,j,k+1)+xi(i,j,k)))*24*24
            end if
          end do
        end do
      end do
      !$OMP END PARALLEL DO   

      call write_bvf(nx,ny,nz-1,nt,X,Y,0.5*(Z(1:nz-1)+Z(2:nz)),T,missing_val,n2)

      end program
