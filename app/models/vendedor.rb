class Vendedor < ActiveRecord::Base
belongs_to :sucursal
has_many :revendedor
has_many :cabfactura
has_many :cabcaja

def self.reveendedorfact(id, fechadesde, fechahasta, sucursal)
	@revendedors = Vendedor.find_by_sql(['select s.sucu_nombre as sucunombre,  sum( if( tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total  ) ) as total, r.reve_nombre as nombre
	from 
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s,
        revendedor as r
	where 
        cf.id_sucursal   = s.id_sucursal
        and  r.id_sucursal   = s.id_sucursal
        and  s.id_sucursal = ?
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
        and  cf.id_revendedor = r.id_revendedor
        and  r.id_vendedor = ?
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
	GROUP BY r.id_revendedor', sucursal, id, fechadesde, fechahasta])
end
def self.totalvendedor(fechadesde, fechahasta, sucursal)
	@totalvendedors = Vendedor.find_by_sql(['select s.sucu_nombre as sucunombre,  sum( if( tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total ) ) as totalvendedor , v.vend_nombre as nombre, v.id_vendedor as idv
	from 
	cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s,
        vendedor as v
     	where 
        s.id_sucursal = ?
        and cf.id_sucursal   = s.id_sucursal
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
        and cf.id_vendedor = v.id_vendedor
        and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
       	GROUP BY v.id_vendedor
        ORDER BY totalvendedor DESC ',sucursal, fechadesde, fechahasta])
end
def self.totalrevendedor(fechadesde, fechahasta, sucursal)
      @totalrevendedors = Vendedor.find_by_sql(['select s.sucu_nombre as sucunombre, sum( if( tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total ) ) as totalrevendedores, v.id_vendedor as idv, v.vend_nombre as nombre
	from 
        cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s,
        vendedor as v,
        revendedor as r
	where
        s.id_sucursal = ? 
        and cf.id_sucursal   = s.id_sucursal
	and  cf.id_tipocomprobante = tc.id_tipocomprobante
        and  cf.id_revendedor = r.id_revendedor
        and  v.id_vendedor = r.id_vendedor
	and  cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
        GROUP BY v.id_vendedor', sucursal, fechadesde, fechahasta])
end

def self.totalpropio(fechadesde, fechahasta, sucursal)
        @totalpropios = Vendedor.find_by_sql(['select s.sucu_nombre as sucunombre, sum( if( tc.tcom_sumaresta="+", cf.cfac_total ,  -cf.cfac_total) ) as totalpropio, v.id_vendedor as idv, v.vend_nombre as nombre
	from 
        cabfactura as cf, 
	tipocomprobante as tc,
	sucursal as s,
        vendedor as v,
        revendedor as r
	where
        s.id_sucursal = ?
        and cf.id_sucursal   = s.id_sucursal
	and cf.id_tipocomprobante = tc.id_tipocomprobante
        and cf.id_revendedor = r.id_revendedor
        and v.id_vendedor = r.id_vendedor
        and cf.id_vendedor = v.id_vendedor
        and r.reve_nombre = v.vend_nombre
	and cf.cfac_fecha >= ? and cf.cfac_fecha <= ?
        GROUP BY v.id_vendedor', sucursal, fechadesde, fechahasta])
end

 #comisiones que se pagan por revendedor
def self.comision(fechadesde, fechahasta, sucursal)
   @comisions = Vendedor.find_by_sql(['select s.sucu_nombre as sucunombre, v.vend_nombre as nombre, v.id_vendedor as idv, sum(if(tc.tcom_sumaresta = "+", cf.cfac_total, -cf.cfac_total)) as totalcomis 
from cabfactura as cf, tipocomprobante as tc, sucursal as s, vendedor as v
where  cf.id_vendedor = v.id_vendedor and s.id_sucursal = ? and cf.id_sucursal = s.id_sucursal and cf.id_tipocomprobante = tc.id_tipocomprobante and cf.cfac_viajantepublico = "B" and cf.cfac_fecha >= ? and cf.cfac_fecha <= ? 
Group by v.id_vendedor', sucursal, fechadesde, fechahasta])
end

end
