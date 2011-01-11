class Contabilidad < ActiveRecord::Base
  
  def self.librodiario(fechadesde, fechahasta)
      @asientos = Cabasiento.find(:all, :conditions => ['casi_fecha >= ? and casi_fecha <= ?', fechadesde, fechahasta])
  end

  def self.renasiento(idcabasiento)
      @renasiento = Renasiento.find(:all, :conditions => ['cabasiento_id = ?', idcabasiento])
  end

  def self.sumadebito(pcuenid, fechaejer, fecha)
      @debito = Renasiento.sum(:rasi_importe, :joins => [:cabasiento], :conditions => ['plandecuenta_id = ? and rasi_importe > 0 and cabasientos.id = cabasiento_id and cabasientos.casi_fecha >= ? and cabasientos.casi_fecha <= ? ' , pcuenid, fechaejer, fecha]) 
  end

  def self.sumacredito(pcuenid, fechaejer, fecha)
     @credito = Renasiento.sum(:rasi_importe, :joins => [:cabasiento], :conditions => ['plandecuenta_id = ? and rasi_importe < 0 and cabasientos.id = cabasiento_id and cabasientos.casi_fecha >= ? and cabasientos.casi_fecha <= ? ' ,pcuenid, fechaejer, fecha])
  end 
  
  def self.sumacuenta(cuentadesde, cuentahasta, fechaejer, fecha )
     @cuenta = Renasiento.sum(:rasi_importe, :joins => [:cabasiento, :plandecuenta], :conditions => ['plandecuentas.pcue_cuenta >= ? and plandecuentas.pcue_cuenta < ? and cabasientos.id = cabasiento_id and cabasientos.casi_fecha >= ? and cabasientos.casi_fecha <= ? ', cuentadesde, cuentahasta, fechaejer, fecha]) 
  end
  
  def self.conmovimiento(fechaejer, fechahasta)
      @plandecuentas = Plandecuenta.find_by_sql(['Select *
from plandecuentas as pc
where pc.pcue_permiteasiento = "No" OR pc.id  IN (SELECT ra.plandecuenta_id FROM cabasientos AS ca, renasientos AS ra WHERE pc.id = ra.plandecuenta_id AND ca.id = ra.cabasiento_id AND ca.casi_fecha >= ?
AND ca.casi_fecha <= ? GROUP BY ra.plandecuenta_id HAVING sum(ra.rasi_importe) !=0)
ORDER BY pc.pcue_cuenta, pcue_nivel', fechaejer, fechahasta])
  end
 
  def self.mayor(cuentaid, fechadesde, fechahasta )
     @mayors = Renasiento.find(:all, :joins => [:cabasiento, :plandecuenta], :conditions => ['plandecuentas.id = ? and cabasientos.id = cabasiento_id and cabasientos.casi_fecha >= ? and cabasientos.casi_fecha <= ? ', cuentaid, fechadesde, fechahasta]) 
  end
  def self.ejercicio(fechadesde)
     @fechainiejer = Ejercicio.find(:first, :conditions => ['year(ejer_desde) = year(?)', fechadesde] )
  end

  def self.saldoant(cuentaid, fechadesde, fechaejer)
    @saldoants = Renasiento.sum(:rasi_importe, :joins => [:cabasiento, :plandecuenta], :conditions => ['plandecuentas.id = ? and cabasientos.id = cabasiento_id and cabasientos.casi_fecha >= ? and cabasientos.casi_fecha < ? ', cuentaid, fechaejer, fechadesde]) 
  end

  def self.conmovimientonaturaleza(fechaejer, fechahasta, naturaleza)
      @plandecuentas = Plandecuenta.find_by_sql(['Select *
from plandecuentas as pc
where pc.pcue_naturaleza = ? and (pc.pcue_permiteasiento = "No" OR pc.id  IN (SELECT ra.plandecuenta_id FROM cabasientos AS ca, renasientos AS ra WHERE pc.id = ra.plandecuenta_id AND ca.id = ra.cabasiento_id AND ca.casi_fecha >= ?
AND ca.casi_fecha <= ? GROUP BY ra.plandecuenta_id HAVING sum(ra.rasi_importe) !=0))
ORDER BY pc.pcue_cuenta, pcue_nivel',naturaleza, fechaejer, fechahasta])
  end

end
