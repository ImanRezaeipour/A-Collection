select Grd_Code, Grd_Year,SUBSTRING(Ascii_,pos_-2,2) month_ from 
(select Grd_Code, Grd_Year,Ascii_,CHARINDEX('015',Ascii_) pos_ from
(select Grd_Code, Grd_Year,
dbo.Ascii_grp_dtl(Grd_M1,1)+
dbo.Ascii_grp_dtl(Grd_M2,2)+
dbo.Ascii_grp_dtl(Grd_M3,3)+
dbo.Ascii_grp_dtl(Grd_M4,4)+
dbo.Ascii_grp_dtl(Grd_M5,5)+
dbo.Ascii_grp_dtl(Grd_M6,6)+
dbo.Ascii_grp_dtl(Grd_M7,7)+
dbo.Ascii_grp_dtl(Grd_M8,8)+
dbo.Ascii_grp_dtl(Grd_M9,9)+
dbo.Ascii_grp_dtl(Grd_M10,10)+
dbo.Ascii_grp_dtl(Grd_M11,11)+
dbo.Ascii_grp_dtl(Grd_M12,12) Ascii_
from dbo.grp_dtl) l1 where CHARINDEX('015',Ascii_)<>0) l2
