truncate table reclamos;
insert into reclamos (recl_estado, recl_nroprt, recl_fecha, recl_nrointerno, recl_codip, recl_descripcionprod, recl_dicpor, recl_dictamen, recl_motivo, recl_bonificacion, recl_notacredito, recl_fechanc )
select  recl_estado, recl_nrointerno, concat( substring(recl_fecha,7,4), '-' , substring( recl_fecha, 4, 2), '-' , substring( recl_fecha, 1,2 ) )
, recl_nroprt, recl_codip, recl_descripcionprod, recl_dicpor, recl_dictamen, recl_motivo, recl_bonificacion, recl_notacredito, 
concat( substring(recl_fechanc,7,4),'-',substring(recl_fechanc, 4,2), '-', substring(recl_fechanc,1,2) ) from reclamostxt;
update reclamos set sucursal_id = recl_nrointerno;

update reclamos set sucursal_id = 88 where sucursal_id = 3;
update reclamos set sucursal_id = 99 where sucursal_id = 4;
update reclamos set sucursal_id = 44 where sucursal_id = 5;
update reclamos set sucursal_id = 33 where sucursal_id = 6;
update reclamos set sucursal_id = 66 where sucursal_id = 7;
update reclamos set sucursal_id = 77 where sucursal_id = 8;
update reclamos set sucursal_id = 100 where sucursal_id = 9;
update reclamos set sucursal_id = 111 where sucursal_id = 10;
update reclamos set sucursal_id = 113 where sucursal_id = 11;


update reclamos set sucursal_id = 8 where sucursal_id = 88;
update reclamos set sucursal_id = 9 where sucursal_id = 99;
update reclamos set sucursal_id = 4 where sucursal_id = 44;
update reclamos set sucursal_id = 3 where sucursal_id = 33;
update reclamos set sucursal_id = 6 where sucursal_id = 66;
update reclamos set sucursal_id = 7 where sucursal_id = 77;
update reclamos set sucursal_id = 10 where sucursal_id = 100;
update reclamos set sucursal_id = 11 where sucursal_id = 111;
update reclamos set sucursal_id = 13 where sucursal_id = 113;




 

