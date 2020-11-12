
sqrt( sum( ( Jan_Goo_PowX_dB(:,1) - Jan_Goo_PowX_dB(:,2) ).^2 ) )
sqrt( sum( ( Jan_Chk_PowX_dB(:,1) - Jan_Goo_PowX_dB(:,2) ).^2 ) )
sqrt( sum( ( Jan_Par_PowX_dB(:,1) - Jan_Goo_PowX_dB(:,2) ).^2 ) )

sqrt( sum( ( Jan_Goo_PowX_dB(:,1) - Jan_Chk_PowX_dB(:,2) ).^2 ) )
sqrt( sum( ( Jan_Chk_PowX_dB(:,1) - Jan_Chk_PowX_dB(:,2) ).^2 ) )
sqrt( sum( ( Jan_Par_PowX_dB(:,1) - Jan_Chk_PowX_dB(:,2) ).^2 ) )

sqrt( sum( ( Jan_Goo_PowX_dB(:,1) - Jan_Par_PowX_dB(:,2) ).^2 ) )
sqrt( sum( ( Jan_Chk_PowX_dB(:,1) - Jan_Par_PowX_dB(:,2) ).^2 ) )
sqrt( sum( ( Jan_Par_PowX_dB(:,1) - Jan_Par_PowX_dB(:,2) ).^2 ) )
