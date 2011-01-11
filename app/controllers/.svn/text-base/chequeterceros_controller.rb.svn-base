class ChequetercerosController < ApplicationController
  #gema para expotar a ecxel
   require 'spreadsheet/excel'
   include Spreadsheet

   before_filter :login_required
   access_control [:list, :new, :create, :update, :edit, :show, :corrigecheque, :informecomprob, :informecomprobxls] => '( rol 5  | rol 6 | rol 7)',
                 :index => '(rol 2 | rol 3 | rol 4  | rol 5  | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  # Correccion de cheques (p/vega)
  def corrigecheque
      #fechas()
    
        if params[:fechadesde].blank? || params[:fechadesde].to_s.length == 10 
         else
         params[:fechadesde] = convierte_fecha(params[:fechadesde])
        end
        if params[:fechahasta].blank? || params[:fechahasta].to_s.length == 10
        else
         params[:fechahasta] = convierte_fecha(params[:fechahasta])
       end
        if (params[:venc]!=nil)
            @chequeterceros = Chequetercero.searchchequevenc(params[:cuit], params[:nrocheque], params[:codbanco], params[:importe],  params[:page])
        else
            @chequeterceros = Chequetercero.searchcheque(params[:cuit], params[:nrocheque], params[:codbanco], params[:fechadesde], params[:fechahasta], params[:importe], params[:page])

    end
  end


  # GET /chequeterceros
  # GET /chequeterceros.xml
  def index 
    if params[:monto].to_s.to_i > 0
     else
      params[:monto] = 20000
    end
    mes  = Time.now.month 
    anio = Time.now.year
    dia  = Time.now.day
    params[:fechaven] = "#{anio}-#{mes}-#{dia}"
    if (params[:bcuit]!=nil)
       chequeterceros = Chequetercero.cuit(params[:cuit], params[:fechaven])
       @chequeterceros = chequeterceros.paginate(:per_page => 20, :page => params[:page] || 1)
    else
       chequeterceros = Chequetercero.search(params[:fechaven] , params[:monto])
       @chequeterceros = chequeterceros.paginate(:per_page => 20, :page => params[:page] || 1)
    end
    @chequetercerospdf = chequeterceros
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chequeterceros }
      prawnto :prawn => {
      :page_size => 'A4'}
      format.pdf  { render :layout => false }
    end
  end

  # GET /chequeterceros/1
  # GET /chequeterceros/1.xml
  # GET /chequeterceros/new
 
  def new
      @chequetercero = Chequetercero.new
      @bancos = Banco.find(:all , :order=>"banc_codigo")
            
      respond_to do |format|
        format.html # new.html.erb 
        format.xml { render :xml => @chequetercero }
      end
  end
 
  def cheque
    @chequeterceros = Chequetercero.consultadecheques(params[:id], params[:fecha])
    @chequerechazados = Chequetercero.chequerechazados(params[:id])
   # @chequerechazadocancelado = Chequetercero.chequerechazadocancelado(params[:idc], session[:sucursal])
  end
  
  # genera excel con los cheques en cartera de monto superior al parametro
  def xls
     #genera el xls
      workbook = Excel.new('public/xls/cheques_cartera.xls')
      # Añadimos hoja LISTA
      hoja_cheques = workbook.add_worksheet("cheques")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true,  :size => 18, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '$#,##0.00')
      f4 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true,  :size => 14, :font =>'Lucida Calligraphy') 
      hoja_cheques.write(1,1,'Cheques en cartera ',f2)
      hoja_cheques.write(3,1,'Fecha de vencimiento mayor igual a :'+params[:fechavencpdf].to_s+' y monto mayor o igual a $'+params[:monto]+'', f4)
      # Fila de cabecera
      @cabecera = %w(CUIT Cant Monto Razon_Social Localidad Provincia)
      columna = 0
      @cabecera.each do |cab|
        hoja_cheques.write(5,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 6
              @chequeterceros = Chequetercero.search(params[:fechaven] , params[:monto])
              if @chequeterceros.size > 0
           
                for l in @chequeterceros
                 # Añado la fila con los datos en sus respectivas columnas
                  hoja_cheques.write(fila,0,l.cter_cuitlibrador)
                  hoja_cheques.write(fila,1,l.cantidad)
                  hoja_cheques.write(fila,2,l.importe, f3)
                  hoja_cheques.write(fila,3,l.razonsocial)
                  hoja_cheques.write(fila,4,l.localidad)
                  hoja_cheques.write(fila,5,l.provincia)
                  # Pasamos a la siguiente empresa en una nueva fila
                  fila += 1
                end
            end
  
     workbook.close
 end

  def edit
    @chequetercero = Chequetercero.find(params[:id])
    @bancos = Banco.find(:all , :order=>"banc_codigo")
  end

  def create
    
    idcomp = params[:idcomp]

    @chequetercero = Chequetercero.new(params[:chequetercero])

    # Busco el ultimo id de casa central y calculo el siguiente
    
    idcheter = Chequetercero.maximum( :id , :conditions => ["sucursal_id = ?",session[:sucursal] ] )

    @chequetercero.id = [ idcheter.to_i + 1 , session[:sucursal] ]

    @chequetercero.motivoingreso_id = 3
    @chequetercero.cter_ingreso = DateTime.now
    @chequetercero.cter_borradocaucion = "N"
    @chequetercero.cter_usuario = session[:user].usur_nombre
    @chequetercero.cter_ultmod  = DateTime.now

    respond_to do |format|
    if @chequetercero.save

        grabaestadocheter( idcheter.to_i + 1 )

        
        grabarengloncompro( idcheter.to_i + 1 , idcomp )

        flash[:notice] = 'El cheque ha sido grabado.'
        format.html { redirect_to(:controller => 'rencargachequeters' , :action => 'index' , :idcomp => idcomp ) }
        format.xml  { render :xml => @chequetercero, :status => :created, :location => @chequetercero }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @chequetercero.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Agrega un registro a la tabla 'estadocheter'
  
  def grabaestadocheter ( idcheter )
    idestado = Estadocheter.maximum( :id ) 
   
    @estadocheter = Estadocheter.new
    @estadocheter.id = idestado.to_i + 1 

    @estadocheter.sucursal_id = session[:sucursal]
    @estadocheter.chequetercero_id = idcheter
    @estadocheter.cabsalidacartera_id = 0
    @estadocheter.destinocheter_id = 0
    @estadocheter.echt_ultmod = DateTime.now
    @estadocheter.echt_usuario = session[:user].usur_nombre

    @estadocheter.save
  end

  # Agrega un registro a la tabla 'rencargachequeter'
  
  def grabarengloncompro ( idcheter , idcomp )
    idrenglon = Rencargachequeter.maximum( :id ) 
   
    @rencargachequeter = Rencargachequeter.new
    @rencargachequeter.id = idrenglon.to_i + 1 
    @rencargachequeter.cabcargachequeter_id = idcomp 
    @rencargachequeter.sucursal_id = session[:sucursal]
    @rencargachequeter.chequetercero_id = idcheter

    @rencargachequeter.save
  end

  def update
    @chequetercero = Chequetercero.find(params[:id])
    @chequetercero.cter_ultmod = DateTime.now
    @chequetercero.cter_usuario = session[:user].usur_nombre
    respond_to do |format|
    #  logger.level = Logger::INFO
      if @chequetercero.update_attributes(params[:chequetercero])
        #para escribir el mysql en log/chequetercero.log
        #  log_to('log/chequetercero.log')
        #  logger.flush
        #  logger.close
        #  logger.level = Logger::WARN

        #guardar el sql del update en la tabla logchequeterceros
        cadena = ""
        str_tokens = @chequetercero.id.to_s.split(",") 
        cadena = "UPDATE `chequetercero` SET `cter_cuitlibrador` = "+@chequetercero.cter_cuitlibrador+", `id_banco` = "+@chequetercero.banco_id.to_s+", `cter_sucursalbanco` = "+@chequetercero.cter_sucursalbanco.to_s+", `cter_vencimiento` = "+"'"+@chequetercero.cter_vencimiento.to_s+"'"+", `cter_nrocuenta` = "+@chequetercero.cter_nrocuenta.to_s+", `cter_usuario` = '"+@chequetercero.cter_usuario+"',`cter_codigopostal` = "+@chequetercero.cter_codigopostal.to_s+", `cter_nrocheque` = "+@chequetercero.cter_nrocheque.to_s+" WHERE (`id_chequetercero` = "+str_tokens[0].lstrip+") AND (`id_sucursal` = "+str_tokens[1].lstrip+")"
        @logchequetercero = Logchequetercero.new
        @logchequetercero.sucursal_id = @chequetercero.sucursal_id
        @logchequetercero.logc_cadenasql = cadena
        @logchequetercero.logc_fecha = DateTime.now
        @logchequetercero.save

        flash[:notice] = 'El cheque ha sido actualizado.'
        format.html {  redirect_to(:controller => 'chequeterceros', :action => 'corrigecheque', :id => 1, :nrocheque => @chequetercero.cter_nrocheque, :page => params[:page] )}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @chequetercero.errors, :status => :unprocessable_entity }
      end
    end
  end

#listado comprobantes internos con fecha de cobro entre dos fechas
def informecomprob
     if params[:fechadesde].blank? 
     else
        params[:fechadesde] = convierte_fecha(params[:fechadesde])
     end
     if params[:fechahasta].blank? 
     else
        params[:fechahasta] = convierte_fecha(params[:fechahasta])
     end
     @comprocheques = Chequetercero.comprocheque(params[:fechadesde], params[:fechahasta])
end
 # genero archivo excel con los comprobantes internos entre fechas de cobro
def informecomprobxls
     #genera el xls
      workbook = Excel.new('public/xls/comprobantes_cobro.xls')
      # Añadimos hoja LISTA
      hoja_cheques = workbook.add_worksheet("cheques")
      f1 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true)
      f2 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true,  :size => 18, :font =>'Lucida Calligraphy') 
      f3 = workbook.add_format(:num_format => '$#,##0.00')
      f4 = workbook.add_format(:color=>"blue", :bold=>1, :italic=>true,  :size => 14, :font =>'Lucida Calligraphy') 
      hoja_cheques.write(1,1,'Listado de comprobantes internos ',f2)
      hoja_cheques.write(3,1,'con fecha de cobro entre :'+params[:fechadesde].to_s+' y '+params[:fechahasta]+'', f4)
      # Fila de cabecera
      @cabecera = %w(Nro_Comprobante Nro_Cheque Fecha Importe_Cobrado)
      columna = 0
      @cabecera.each do |cab|
        hoja_cheques.write(5,columna,cab,f1)
        columna += 1
      end
      # Una fila para cada items
          fila = 6
              @comprocheques = Chequetercero.comprocheque(params[:fechadesde], params[:fechahasta])
              if @comprocheques.size > 0
           
                for l in @comprocheques
                  # Añado la fila con los datos en sus respectivas columnas
                  hoja_cheques.write(fila,0,l.nrocomprobante)
                  hoja_cheques.write(fila,1,l.nrocheque)
                  hoja_cheques.write(fila,2,l.fecha)
                  hoja_cheques.write(fila,3,l.importecobrado,f3)
                  # Pasamos a la siguiente empresa en una nueva fila
                  fila += 1
                end
            end
  
     workbook.close
end

end
