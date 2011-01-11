require 'composite_primary_keys'
class Chequetercero < ActiveRecord::Base
 belongs_to :banco
 belongs_to :sucursal
 belongs_to :cliente, :foreign_key => [:cliente_id, :sucursal_id]
 has_many  :depositocaucion
 has_many  :estadocheter
 has_many  :devueltocaucion
 has_one   :rencargachequeter
 belongs_to :cabfactura, :foreign_key => [:cabfactura_id, :sucursal_id]
 belongs_to :cabrecibo, :foreign_key => [:cabrecibo_id, :sucursal_id]
 belongs_to :cabcaja, :foreign_key => [:cabcaja_id, :sucursal_id]
 set_primary_keys :id, :sucursal_id


#para que vega busque los cheques a modificar
def self.searchcheque(cuit, nrocheque, codbanco, fechadesde, fechahasta, importe, page)

    condiciones = "cter_vencimiento >= ? and cter_vencimiento <= ? "
    if !cuit.blank?
       condiciones = condiciones + "and cter_cuitlibrador = ?"
    end
    if !nrocheque.blank?
       condiciones = condiciones + " and cter_nrocheque = ?"
    end
    if !codbanco.blank?
       condiciones = condiciones + " and bancos.banc_codigo = ?"
    end
    if !importe.blank?
       condiciones = condiciones + " and cter_importe = ?"
    end

    condicion = []
    condicion << condiciones
    condicion << "#{fechadesde}"
    condicion << "#{fechahasta}"
    
    if !cuit.blank?
       condicion << "#{cuit}"
    end
    if !nrocheque.blank?
       condicion << "#{nrocheque}"
    end
    if !codbanco.blank?
       condicion << "#{codbanco}"
    end
    if !importe.blank?
       impor = "#{importe}"
       condicion << impor.to_d
    end

    @chequeterceros = Chequetercero.paginate(:all, :joins => [:banco], :conditions => condicion , :order => 'cter_vencimiento desc', :per_page => 20, :page => page || 1 )

end
def self.searchchequevenc(cuit, nrocheque, codbanco, importe, page)

    condiciones = "cter_vencimiento = 0000-00-000"
    if !cuit.blank?
       condiciones = condiciones + "and cter_cuitlibrador = ?"
    end
    if !nrocheque.blank?
       condiciones = condiciones + " and cter_nrocheque = ?"
    end
    if !codbanco.blank?
       condiciones = condiciones + " and bancos.banc_codigo = ?"
    end
    if !importe.blank?
       condiciones = condiciones + " and cter_importe = ?"
    end

    condicion = []
    condicion << condiciones
    
    if !cuit.blank?
       condicion << "#{cuit}"
    end
    if !nrocheque.blank?
       condicion << "#{nrocheque}"
    end
    if !codbanco.blank?
       condicion << "#{codbanco}"
    end
    if !importe.blank?
       impor = "#{importe}"
       condicion << impor.to_d
    end

    @chequeterceros = Chequetercero.paginate(:all, :joins => [:banco], :conditions => condicion , :order => 'cter_vencimiento desc', :per_page => 20, :page => page || 1 )

end

def self.search(fechaven, monto)
	@chequeterceros = Chequetercero.find_by_sql(['select cter_cuitlibrador, sum(cter_importe) as importe, count(*) as cantidad, cuitcheques.ccheq_razonsocial as razonsocial, cuitcheques.ccheq_localidad as localidad, cuitcheques.ccheq_provincia as provincia
from chequetercero as c LEFT JOIN cuitcheques ON c.cter_cuitlibrador=cuitcheques.ccheq_cuit, sucursal as s, estadocheter as e, banco as b 
where c.id_chequetercero = e.id_chequetercero and  c.id_sucursal = e.id_sucursal and  c.id_sucursal = s.id_sucursal and   c.id_banco = b.id_banco  and c.cter_vencimiento >= ?
GROUP BY cter_cuitlibrador 
HAVING importe >= ?
ORDER BY importe DESC', fechaven, monto]) 
end

#busqueda de cheques por cuit
def self.cuit(cuit, fechaven)
	@chequeterceros = Chequetercero.find_by_sql(['select cter_cuitlibrador, sum(cter_importe) as importe, count(*) as cantidad, cuitcheques.ccheq_razonsocial as razonsocial, cuitcheques.ccheq_localidad as localidad, cuitcheques.ccheq_provincia as provincia
from chequetercero as c LEFT JOIN cuitcheques ON c.cter_cuitlibrador=cuitcheques.ccheq_cuit, sucursal as s, estadocheter as e, banco as b 
where c.id_chequetercero = e.id_chequetercero and  c.id_sucursal = e.id_sucursal and  c.id_sucursal = s.id_sucursal and   c.id_banco = b.id_banco  and c.cter_cuitlibrador = ? and c.cter_vencimiento >= ?
GROUP BY cter_cuitlibrador', cuit, fechaven]) 
end

def self.consultadecheques(id, fecha)
	@chequeterceros = Chequetercero.find_by_sql(['select * from sucursal, chequetercero 
            where sucursal.id_sucursal = chequetercero.id_sucursal 
	    and cter_cuitlibrador = ?
	    and cter_vencimiento >= ?', id, fecha])
end

def self.chequerechazados(id)
	@chequerechazados = Chequetercero.find_by_sql(['select * from chequetercero as c, sucursal as s, regucheque as r, motivochereg as m
                    where c.id_sucursal = r.id_sucursal
                    and c.id_chequetercero = r.id_chequetercero
                    and m.id_motivochereg = r.id_motivochereg
                    and c.id_sucursal = s.id_sucursal 
                    and m.motc_tipo = "H"
                    and cter_cuitlibrador = ?', id])
end

# Si el cheque rechazado esta cancelado
def self.chequerechazadocancelado(idc, sucursal)
	@chequerechazadocancelados = Chequetercero.find_by_sql(['select sum(r.regc_importe) as  importe, sum(r.regc_gastos ) as  gastos , sum(r.regc_intereses) as intereses , sum(r.regc_importe + r.regc_gastos + r.regc_intereses) as  total  from chequetercero as c, regucheque as r, repocheque as rp, sucursal as s
                    where c.id_sucursal = s.id_sucursal
                    and r.id_sucursal = s.id_sucursal
                    and rp.id_sucursal = s.id_sucursal
                    and s.id_sucursal = ?
                    and c.id_chequetercero = r.id_chequetercero
                    and c.id_chequetercero = ?
                    and r.id_regucheque = rp.id_regucheque ', sucursal, idc])
end

#metodo para buscar los comprobantes internos con fecha de cobro entre fechas
def self.comprocheque(fechadesde, fechahasta)
	@comprocheques = Chequetercero.find_by_sql(['SELECT c.cter_nrocheque as nrocheque, rg.id_regucheque as nrocomprobante, rp.repc_importe as importecobrado, (rg.regc_importe + rg.regc_gastos + rg.regc_intereses) as importe, rp.repc_fecha as fecha, c.cter_importe as chequeimporte
FROM sucursal as s, repocheque AS rp, regucheque AS rg
LEFT JOIN chequetercero AS c ON rg.id_chequetercero = c.id_chequetercero AND rg.id_sucursal = c.id_sucursal
WHERE s.id_sucursal = rp.id_sucursal and rp.id_regucheque = rg.id_regucheque AND rp.repc_fecha >= ? AND rp.repc_fecha <= ?
ORDER BY rp.repc_fecha, c.cter_nrocheque', fechadesde, fechahasta])

end

end


