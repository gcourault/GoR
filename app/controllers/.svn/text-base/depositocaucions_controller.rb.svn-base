class DepositocaucionsController < ApplicationController
 
   before_filter :login_required
   access_control  [:list, :new, :create, :update, :edit, :show, :index, :destroy, :pendientelistado, :nuevo, :suma, :fechas] => '(rol 5 | rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  def fechas
    if params[:fechadesde].blank?
      else
        params[:fechadesde] = convierte_fecha(params[:fechadesde])
    end
    if params[:fechahasta].blank?
     else
       params[:fechahasta] = convierte_fecha(params[:fechahasta])
    end
  end

  # GET /depositocaucions
  # GET /depositocaucions.xml
  def index
    fechas()
    @depositocaucionpendis = Depositocaucion.busqueda(params[:fechadesde], params[:fechahasta], params[:nrocheq])
    @depositocaucions = Depositocaucion.busquedatodo(params[:fechadesde], params[:fechahasta],  params[:nrocheq])

    #para sacar los subtotales
    agrup = []
    @depositocaucions.each do |v|
         agrup <<  v.dcau_nroboletadeposito.to_i
    end
    @agrups = agrup.uniq

    @totalvens = Depositocaucion.totalven(params[:fechadesde], params[:fechahasta])
    @acreditados = Depositocaucion.acreditado(params[:fechadesde], params[:fechahasta])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @depositocaucions }
    end
  end
  
  def pendientelistado
    @listadopendientes = Depositocaucion.listadopendiente()
    idlist = []
    @listadopendientes.each do |list|
       idlist <<  list.listado.to_i
    end
    @idlists = idlist.uniq
  end

  # ingresa deposito de caucion cuando se acreditan los cheches (actualizacion multiple)
  def nuevo
       if params[:fechaacred].blank?
       else
        params[:fechaacred] = Date.civil params[:fechaacred]["year"].to_i, params[:fechaacred]["month"].to_i, params[:fechaacred]["day"].to_i
       end
       if params[:dcau_nroboletadeposito].blank?
        params[:dcau_nroboletadeposito] = '000'
       end
       if params[:chequetercero_ids].blank?
         else
       	  params[:chequetercero_ids].each { |item_id|
          @depositocaucion = Depositocaucion.new
          @depositocaucion.dcau_fechadeposito = params[:fechaacred].to_s.to_date
          @depositocaucion.conceptocaucion_id = params[:conceptocaucion].to_s
          @depositocaucion.dcau_nroboletadeposito = params[:dcau_nroboletadeposito].to_s
          @depositocaucion.chequetercero_id = item_id.to_i
          @depositocaucion.sucursal_id = 11
          @depositocaucion.dcau_ultmod = DateTime.now
          @depositocaucion.dcau_usuario = session[:user].usur_nombre
          @depositocaucion.save!
      	
          if params[:conceptocaucion].to_s == "2" 
              @cheterc = Chequetercero.find_by_id_and_sucursal_id(item_id, '11')
              @estadocheq = Estadocheter.find_by_chequetercero_id_and_sucursal_id(item_id, '11')
                #grabar devueltocaucions
                @devueltocaucion = Devueltocaucion.new
                @devueltocaucion.chequetercero_id = item_id
                @devueltocaucion.sucursal_id = 11
                @devueltocaucion.devc_tipo = "R"
                @devueltocaucion.devc_fecha = params[:fechaacred].to_s.to_date
                @devueltocaucion.devc_detalle = 'Devolucion(REINGRESO A CARTERA) Ch/Nº '+@cheterc.cter_nrocheque.to_s+' listado('+@cheterc.listadocaucion_id.to_s+')'
                @devueltocaucion.devc_importe = @cheterc.cter_importe
                @devueltocaucion.devc_cabsalidacarteraant = @estadocheq.cabsalidacartera_id
                @devueltocaucion.devc_usuario = session[:user].usur_nombre
                @devueltocaucion.devc_ultmod = DateTime.now
                @devueltocaucion.save

                #hacer asiento
                @cabasiento = Cabasiento.new
                @cabasiento.sucursal_id = 11
                @cabasiento.cabcaja_id = 0
		@cabasiento.casi_fecha = params[:fechaacred].to_s.to_date
                @cabasiento.casi_cerrado = "No"
           	@cabasiento.casi_borrado = "No"
		@cabasiento.casi_importado = "No"
                @cabasiento.casi_descripcion = "Reingreso de Caucion"
                @cabasiento.casi_usuario =  session[:user].usur_nombre
                @cabasiento.casi_ultmod = DateTime.now
                @cabasiento.save
                
                #renglones del asiento
                nrocabasiento = Cabasiento.maximum(:id)
                @renasiento = Renasiento.new
                @renasiento.cabasiento_id = nrocabasiento
                @renasiento.plandecuenta_id = 21
                @renasiento.rasi_importe =  @cheterc.cter_importe
                @renasiento.save
                @renasiento = Renasiento.new
                @renasiento.cabasiento_id = nrocabasiento
                @renasiento.plandecuenta_id = 132
                @renasiento.rasi_importe =  -@cheterc.cter_importe
                @renasiento.save
                 
                # pone a cero los estadocheter
                @estadocheter = Estadocheter.find_by_chequetercero_id_and_sucursal_id(item_id, '11')
                @estadocheter.update_attribute(:cabsalidacartera_id, '0')
                @estadocheter.update_attribute(:destinocheter_id, '0')
                @estadocheter.update_attribute(:echt_usuario,  session[:user].usur_nombre)
                @estadocheter.update_attribute(:echt_ultmod, DateTime.now)
                end
                if params[:conceptocaucion].to_s == "3" 
                 @cheterc = Chequetercero.find_by_id_and_sucursal_id(item_id, '11')
                 @estadocheq = Estadocheter.find_by_chequetercero_id_and_sucursal_id(item_id, '11')
                 #grabar devueltocaucion Gesv- Manual
                 @devueltocaucion = Devueltocaucion.new
                 @devueltocaucion.chequetercero_id = item_id
                 @devueltocaucion.sucursal_id = 11
                 @devueltocaucion.devc_tipo = "R"
                 @devueltocaucion.devc_fecha = params[:fechaacred].to_s.to_date
                 @devueltocaucion.devc_detalle = 'Devolucion (GESVAL - DEP.MANUAL) Ch/Nº '+@cheterc.cter_nrocheque.to_s+' listado('+@cheterc.listadocaucion_id.to_s+')'
                 @devueltocaucion.devc_importe = @cheterc.cter_importe
                 @devueltocaucion.devc_cabsalidacarteraant = @estadocheq.cabsalidacartera_id
                 @devueltocaucion.devc_usuario = session[:user].usur_nombre
                 @devueltocaucion.devc_ultmod = DateTime.now
                 @devueltocaucion.save

                 #hacer asiento
                 @cabasiento = Cabasiento.new
                 @cabasiento.sucursal_id = 11
                 @cabasiento.cabcaja_id = 0
		 @cabasiento.casi_fecha = params[:fechaacred].to_s.to_date
                 @cabasiento.casi_cerrado = "No"
           	 @cabasiento.casi_borrado = "No"
		 @cabasiento.casi_importado = "No"
                 @cabasiento.casi_descripcion = "GESVAL - DEP.MANUAL"
                 @cabasiento.casi_usuario =  session[:user].usur_nombre
                 @cabasiento.casi_ultmod = DateTime.now
                 @cabasiento.save
                
                 #renglones del asiento
                 nrocabasiento = Cabasiento.maximum(:id)
                 @renasiento = Renasiento.new
                 @renasiento.cabasiento_id = nrocabasiento
                 @renasiento.plandecuenta_id = 7
                 @renasiento.rasi_importe =  @cheterc.cter_importe
                 @renasiento.save
                 @renasiento = Renasiento.new
                 @renasiento.cabasiento_id = nrocabasiento
                 @renasiento.plandecuenta_id = 132
                 @renasiento.rasi_importe =  -@cheterc.cter_importe
                 @renasiento.save
                 
                 # pone a cero los estadocheter
                 @estadocheter = Estadocheter.find_by_chequetercero_id_and_sucursal_id(item_id, '11')
                 @estadocheter.update_attribute(:cabsalidacartera_id, '0')
                 @estadocheter.update_attribute(:destinocheter_id, '0')
                 @estadocheter.update_attribute(:echt_usuario,  session[:user].usur_nombre)
                 @estadocheter.update_attribute(:echt_ultmod, DateTime.now)
                
           end
          }
      end
      # para actualizar las busquedas
      fechas()
      @depositocaucionpendis = Depositocaucion.busqueda(params[:fechadesde], params[:fechahasta], params[:nrocheq])
      @depositocaucions = Depositocaucion.busquedatodo(params[:fechadesde], params[:fechahasta], params[:nrocheq])
      #para sacar los subtotales
      agrup = []
      @depositocaucions.each do |v|
         agrup <<  v.dcau_nroboletadeposito.to_i
      end
      @agrups = agrup.uniq
      @totalvens = Depositocaucion.totalven(params[:fechadesde], params[:fechahasta])
      @acreditados = Depositocaucion.acreditado(params[:fechadesde], params[:fechahasta])
      render :partial => "nuevo", :layout => "application"

      #redirect_to :action => 'index'
      #render(:update) { |page| page.call 'location.reload' }
      #respond_to do |format|  format.js {render(:update) { |page| page.call 'location.reload' }} end 
      #render :update do |page|   page.form.reset 'uploadPhotoForm'   end
  end
 
  #esta funcion no se usa, dejo de ejemplo
  def suma
   importe = 0
   if params[:depositocaucion_ids].blank? 
   else 
      params[:depositocaucion_ids].each { |item_id|
      item = Depositocaucion.find(item_id.to_i)
      params[:idcheque] = item.chequetercero_id
      @buscaimportes = Depositocaucion.buscaimporte(params[:idcheque])
      imp = 0
      @buscaimportes.each {|i| imp = imp + i.importe.to_d }
      importe = importe + imp
      }
   end 
     params[:importe] = importe 
     render :partial => "suma"
  end

  # GET /depositocaucions/1
  # GET /depositocaucions/1.xml
  def show
    @depositocaucion = Depositocaucion.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @depositocaucion }
    end
  end

  # GET /depositocaucions/new
  # GET /depositocaucions/new.xml
  def new
    @depositocaucion = Depositocaucion.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @depositocaucion }
    end
  end

  # GET /depositocaucions/1/edit
  def edit
    @depositocaucion = Depositocaucion.find(params[:id])
  end

  # POST /depositocaucions
  # POST /depositocaucions.xml
  def create
    @depositocaucion = Depositocaucion.new(@depositocaucionnuevo)
    respond_to do |format|
      if @depositocaucion.save
        flash[:notice] = 'Depositocaucion was successfully created.'
        format.html { redirect_to(@depositocaucion) }
        format.xml  { render :xml => @depositocaucion, :status => :created, :location => @depositocaucion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @depositocaucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /depositocaucions/1
  # PUT /depositocaucions/1.xml
  def update
    @depositocaucion = Depositocaucion.find(params[:id])
    respond_to do |format|
      if @depositocaucion.update_attributes(params[:depositocaucion])
        flash[:notice] = 'Depositocaucion was successfully updated.'
        format.html { redirect_to(@depositocaucion) }
        format.xml  { head :ok }
      else      
        format.html { render :action => "edit" }
        format.xml  { render :xml => @depositocaucion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /depositocaucions/1
  # DELETE /depositocaucions/1.xml
  def destroy
     @depositocaucion = Depositocaucion.find(params[:id])
     #antes de borrar hacer asiento y cambiarlos estado en estadochequeter
     @cheterc = Chequetercero.find_by_id_and_sucursal_id(@depositocaucion.chequetercero_id, '11')
     @devueltocaucion = Devueltocaucion.find_by_chequetercero_id_and_sucursal_id(@depositocaucion.chequetercero_id, '11')
     # @devueltocaucion.chequetercero_id = @cheterc.id 
     # si es un reingreso hace el asiento y le vuelve los estados de pendiente en caucion
     if (@depositocaucion.conceptocaucion_id.to_s == "2")
          #hacer asiento
          @cabasiento = Cabasiento.new
          @cabasiento.sucursal_id = 11
          @cabasiento.cabcaja_id = 0
          @cabasiento.casi_fecha = DateTime.now
          @cabasiento.casi_cerrado = "No"
          @cabasiento.casi_borrado = "No"
	  @cabasiento.casi_importado = "No"
          @cabasiento.casi_descripcion = "Salida de reingreso de Caucion"
          @cabasiento.casi_usuario =  session[:user].usur_nombre
          @cabasiento.casi_ultmod = DateTime.now
          @cabasiento.save
                
          #renglones del asiento
          nrocabasiento = Cabasiento.maximum(:id)
          @renasiento = Renasiento.new
          @renasiento.cabasiento_id = nrocabasiento
          @renasiento.plandecuenta_id = 132
          @renasiento.rasi_importe =  @cheterc.cter_importe
          @renasiento.save
          @renasiento = Renasiento.new
          @renasiento.cabasiento_id = nrocabasiento
          @renasiento.plandecuenta_id = 21
          @renasiento.rasi_importe =  -@cheterc.cter_importe
          @renasiento.save

          # reestablecer los estados de estadocheter
          @estadocheter = Estadocheter.find_by_chequetercero_id_and_sucursal_id(@depositocaucion.chequetercero_id, '11')
          @estadocheter.update_attribute(:cabsalidacartera_id, @devueltocaucion.devc_cabsalidacarteraant) if @devueltocaucion
          @estadocheter.update_attribute(:destinocheter_id, '13')
          @estadocheter.update_attribute(:echt_usuario,  session[:user].usur_nombre)
          @estadocheter.update_attribute(:echt_ultmod, DateTime.now)
          #borrar el reingreso de devueltocaucions
          @devueltocaucion.destroy 
    end
    if (@depositocaucion.conceptocaucion_id.to_s == "3")
          #hacer asiento
          @cabasiento = Cabasiento.new
          @cabasiento.sucursal_id = 11
          @cabasiento.cabcaja_id = 0
          @cabasiento.casi_fecha = DateTime.now
          @cabasiento.casi_cerrado = "No"
          @cabasiento.casi_borrado = "No"
	  @cabasiento.casi_importado = "No"
          @cabasiento.casi_descripcion = "Salida de GESVAL - DEP.MANUAL"
          @cabasiento.casi_usuario =  session[:user].usur_nombre
          @cabasiento.casi_ultmod = DateTime.now
          @cabasiento.save
                
          #renglones del asiento
          nrocabasiento = Cabasiento.maximum(:id)
          @renasiento = Renasiento.new
          @renasiento.cabasiento_id = nrocabasiento
          @renasiento.plandecuenta_id = 132
          @renasiento.rasi_importe =  @cheterc.cter_importe
          @renasiento.save
          @renasiento = Renasiento.new
          @renasiento.cabasiento_id = nrocabasiento
          @renasiento.plandecuenta_id = 7
          @renasiento.rasi_importe =  -@cheterc.cter_importe
          @renasiento.save
 
          # reestablecer los estados de estadocheter
          @estadocheter = Estadocheter.find_by_chequetercero_id_and_sucursal_id(@depositocaucion.chequetercero_id, '11')
          @estadocheter.update_attribute(:cabsalidacartera_id, @devueltocaucion.devc_cabsalidacarteraant) if @devueltocaucion
          @estadocheter.update_attribute(:destinocheter_id, '13')
          @estadocheter.update_attribute(:echt_usuario,  session[:user].usur_nombre)
          @estadocheter.update_attribute(:echt_ultmod, DateTime.now)
          #borrar el reingreso de devueltocaucions
          @devueltocaucion.destroy
    end

    #borrar el ingreso de depositocaucion
    @depositocaucion.destroy 
    respond_to do |format|
      format.html { redirect_to(depositocaucions_url) }
      format.xml  { head :ok }
    end
  end

end
