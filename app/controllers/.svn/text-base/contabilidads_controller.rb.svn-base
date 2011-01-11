 #gema para expotar a ecxel
   require 'spreadsheet/excel'
   include Spreadsheet
class ContabilidadsController < ApplicationController
 
   before_filter :login_required
   access_control  [:index, :fechas, :diario, :mayor, :balancesys, :balanceg, :resultado, :mayorxls, :balancegxls, :resultadoxls] => '(rol 5 | rol 6 | rol 7)'
 
  def permission_denied
     flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
     return redirect_to(:controller => 'login', :action => 'denied')
  end
 
  def fechas
    params[:fechadesde] = convierte_fecha(params[:fechadesde]) if !params[:fechadesde].blank?
    params[:fechahasta] = convierte_fecha(params[:fechahasta]) if !params[:fechahasta].blank?
  end
  # GET /contabilidads
  # GET /contabilidads.xml
  
 def diario
    fechas()
    @ejercicios = Ejercicio.find(:all)
    @asientos = Contabilidad.librodiario(params[:fechadesde], params[:fechahasta])

 
 end

 def mayor
   fechas()
   @plandecuentas = Plandecuenta.find(:all, :conditions =>['pcue_permiteasiento = "Si"'], :order => ['pcue_descripcion'])
   @mayors = Contabilidad.mayor(params[:plandecuenta], params[:fechadesde], params[:fechahasta])
  
 end
 def mayorxls
      saldo = 0
      debe = 0
      haber = 0
      sumdebe = 0
      sumhaber = 0
      @cuenta = Plandecuenta.find(params[:cuenta])      
      cuentanombre = @cuenta.nombre_codigo
      workbook = Excel.new('public/xls/mayor.xls')
      hoja_listas = workbook.add_worksheet("Lista")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true, :size => 16, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '#,##0.00', :align=>"right")
      f4 = workbook.add_format(:num_format => '#,##0.00', :color=>"blue", :bold=>1, :italic=>true, :align=>"right")
      hoja_listas.write(1,1,'Mayor de la cuenta '+cuentanombre.to_s+' en el periodo '+params[:from_time].to_s+' al '+params[:to_time].to_s+'',f2)
      # Fila de cabecera
        @cabecera = %w(Fecha Detalle Debe Haber Saldo Asiento)
      
      columna = 0
      @cabecera.each do |cab|
        hoja_listas.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
        fila = 4
      @mayors = Contabilidad.mayor(params[:cuenta], params[:from_time], params[:to_time])
      if params[:saldo].to_s == "Con saldo anterior"
         @fechainiejer = Contabilidad.ejercicio(params[:from_time])
         @saldoants = Contabilidad.saldoant(params[:cuenta], params[:from_time], @fechainiejer.ejer_desde)
         saldo = @saldoants.to_s.to_d
         hoja_listas.write(fila,1,"Saldo Anterior")  
         hoja_listas.write(fila,4,@saldoants,f3)
         fila += 1 
       end
      for mayor in  @mayors 
        debe = mayor.rasi_importe.to_s.to_d > 0 ? mayor.rasi_importe.to_s : " "
        haber = mayor.rasi_importe.to_s.to_d < 0 ? mayor.rasi_importe.to_s : " "
        sumdebe = sumdebe + debe.to_s.to_d
        sumhaber = sumhaber + haber.to_s.to_d
        saldo = saldo + mayor.rasi_importe.to_s.to_d
        hoja_listas.write(fila,0,mayor.cabasiento.casi_fecha.to_s)  
        hoja_listas.write(fila,1,mayor.cabasiento.casi_descripcion)  
        hoja_listas.write(fila,2,debe.to_s,f3)
        hoja_listas.write(fila,3,haber.to_s,f3)
        hoja_listas.write(fila,4,saldo,f3)
        hoja_listas.write(fila,5,mayor.cabasiento.id.to_s)
        fila += 1 
      end
        hoja_listas.write(fila,1,"TOTALES",f1)  
        hoja_listas.write(fila,2,sumdebe,f4)
        hoja_listas.write(fila,3,sumhaber,f4)
        hoja_listas.write(fila,4,saldo,f4)
    workbook.close
 end
 
 def balancesys
    fechas()
    @ejercicios = Ejercicio.find(:all)
    @plandecuentas = Plandecuenta.find(:all, :conditions => ['pcue_permiteasiento = "Si"'], :order => ['pcue_cuenta, pcue_nivel'])
 end
  
 def balanceg
   fechas()
   @ejercicios = Ejercicio.find(:all)
   @naturalezas = ["Activo", "Pasivo", "PatrimonioNeto", "Resultados", "CuentadeOrden"]
   @niveles = ["1", "2", "3", "4", "5"] 
   @plandecuentas = Plandecuenta.find(:all, :order => ['pcue_cuenta, pcue_nivel'])
   if params[:todo].to_s == "Cuentas con movimientos"
       #@ejrcic = Ejercicio.find(params[:ejercicio])
       @plandecuentas = Contabilidad.conmovimiento(params[:fechadesde], params[:fechahasta])
   end
 end

 def balancegxls
      acumcuenta = 0
      acumtotal = 0 
      cuentanivel1 = params[:cuentan1]
      cuentanivel2 = params[:cuentan2]
      cuentanivel3 = params[:cuentan3]
      cuentanivel4 = params[:cuentan4]
      workbook = Excel.new('public/xls/balancegeneral.xls')
      # Añadimos hoja LISTA
      hoja_listas = workbook.add_worksheet("Lista")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true, :size => 16, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '#,##0.00', :align=>"right")
      f4 = workbook.add_format(:num_format => '#,##0.00', :color=>"blue", :bold=>1, :italic=>true, :align=>"right")
      hoja_listas.write(1,1,'Balance general del periodo '+params[:from_time].to_s+' al '+params[:to_time].to_s+'',f2)
      # Fila de cabecera
        @cabecera = %w(Cuenta Saldo Saldo Saldo Saldo Saldo)
      
      columna = 0
      @cabecera.each do |cab|
        hoja_listas.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 4
       @naturalezas = ["Activo", "Pasivo", "PatrimonioNeto", "Resultados", "CuentadeOrden"]
       @niveles = ["1", "2", "3", "4", "5"] 
       if params[:todo].to_s == "Cuentas con movimientos"
          @plandecuentas = Contabilidad.conmovimiento(params[:from_time], params[:to_time])
       else
          @plandecuentas = Plandecuenta.find(:all, :order => ['pcue_cuenta, pcue_nivel'])
       end
     
       for pcuen in @plandecuentas
         for naturaleza in @naturalezas 
            for nivel in @niveles
              if pcuen.pcue_naturaleza.to_s == naturaleza.to_s && pcuen.pcue_nivel.to_s == nivel.to_s 
                 if pcuen.pcue_nivel.to_s == @niveles[0].to_s 
                   @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel1.to_i), params[:from_time], params[:to_time])
                   acumtotal = acumtotal + @acumcuenta 
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,5,@acumcuenta,f3)
                   fila += 1  
                 elsif pcuen.pcue_nivel.to_s == @niveles[1].to_s 
 	           @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel2.to_i), params[:from_time], params[:to_time])
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,4,@acumcuenta,f3)
                   fila += 1  
                 elsif pcuen.pcue_nivel.to_s == @niveles[2].to_s 
                   @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel3.to_i), params[:from_time], params[:to_time])
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,3,@acumcuenta,f3)
                   fila += 1  
                elsif pcuen.pcue_nivel.to_s == @niveles[3].to_s
                  @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel4.to_i), params[:from_time], params[:to_time]) 
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,2,@acumcuenta,f3)
                   fila += 1  
                elsif pcuen.pcue_nivel.to_s == @niveles[4].to_s 
                  @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, pcuen.pcue_cuenta.to_i, params[:from_time], params[:to_time]) 
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,1,@acumcuenta,f3)
                   fila += 1  
                end
                  
            end
        end # end cuentas 
  end  # end nivel 
end  # end naturaleza 
    hoja_listas.write(fila,0,"SALDO",f1)  
    hoja_listas.write(fila,5,acumtotal,f4)
    workbook.close
  
 end

 def detalleasiento
    @asiento = Cabasiento.find(params[:id])
    @renglon = Renasiento.find(:all, :conditions => ['cabasiento_id = ?', params[:id]])
 end
 
 def resultado
      fechas()
      @ejercicios = Ejercicio.find(:all)
      @niveles = ["1", "2", "3", "4", "5"] 
      @plandecuentas = Plandecuenta.find(:all, :conditions => ['pcue_naturaleza like "Resultados"'], :order => ['pcue_cuenta, pcue_nivel'])
      if params[:todo].to_s == "Cuentas con movimientos"
       @ejrcic = Ejercicio.find(params[:ejercicio])
       @plandecuentas = Contabilidad.conmovimientonaturaleza(params[:fechadesde], params[:fechahasta], params[:naturaleza])
      end
 end
 def resultadoxls
      acumcuenta = 0
      acumtotal = 0 
      cuentanivel1 = params[:cuentan1]
      cuentanivel2 = params[:cuentan2]
      cuentanivel3 = params[:cuentan3]
      cuentanivel4 = params[:cuentan4]
      workbook = Excel.new('public/xls/resultado.xls')
      # Añadimos hoja LISTA
      hoja_listas = workbook.add_worksheet("Lista")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true, :size => 16, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '#,##0.00', :align=>"right")
      f4 = workbook.add_format(:num_format => '#,##0.00', :color=>"blue", :bold=>1, :italic=>true, :align=>"right")
      hoja_listas.write(1,1,'Estado de resultado del periodo '+params[:from_time].to_s+' al '+params[:to_time].to_s+'',f2)
      # Fila de cabecera
        @cabecera = %w(Cuenta Saldo Saldo Saldo Saldo Saldo)
      
      columna = 0
      @cabecera.each do |cab|
        hoja_listas.write(3,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 4
       @naturalezas = ["Activo", "Pasivo", "PatrimonioNeto", "Resultados", "CuentadeOrden"]
       @niveles = ["1", "2", "3", "4", "5"] 
       if params[:todo].to_s == "Cuentas con movimientos"
           @plandecuentas = Contabilidad.conmovimientonaturaleza(params[:from_time], params[:to_time], params[:naturaleza])
       else
           @plandecuentas = Plandecuenta.find(:all, :conditions => ['pcue_naturaleza like "Resultados"'], :order => ['pcue_cuenta, pcue_nivel'])
       end
     
       for pcuen in @plandecuentas
          for nivel in @niveles
              if pcuen.pcue_nivel.to_s == nivel.to_s 
                 if pcuen.pcue_nivel.to_s == @niveles[0].to_s 
                   @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel1.to_i), params[:from_time], params[:to_time])
                   acumtotal = acumtotal + @acumcuenta 
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,5,@acumcuenta,f3)
                   fila += 1  
                 elsif pcuen.pcue_nivel.to_s == @niveles[1].to_s 
 	           @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel2.to_i), params[:from_time], params[:to_time])
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,4,@acumcuenta,f3)
                   fila += 1  
                 elsif pcuen.pcue_nivel.to_s == @niveles[2].to_s 
                   @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel3.to_i), params[:from_time], params[:to_time])
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,3,@acumcuenta,f3)
                   fila += 1  
                elsif pcuen.pcue_nivel.to_s == @niveles[3].to_s
                  @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta.to_i, (pcuen.pcue_cuenta.to_i + cuentanivel4.to_i), params[:from_time], params[:to_time]) 
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,2,@acumcuenta,f3)
                   fila += 1  
                elsif pcuen.pcue_nivel.to_s == @niveles[4].to_s 
                  @acumcuenta = Contabilidad.sumacuenta(pcuen.pcue_cuenta, pcuen.pcue_cuenta.to_i, params[:from_time], params[:to_time]) 
                   hoja_listas.write(fila,0,pcuen.codigo_nombre)  
                   hoja_listas.write(fila,1,@acumcuenta,f3)
                   fila += 1  
                end
                  
            end
        end # end cuentas 
  end  # end nivel 

    hoja_listas.write(fila,0,"SALDO",f1)  
    hoja_listas.write(fila,5,acumtotal,f4)
    workbook.close
 
 end
end
