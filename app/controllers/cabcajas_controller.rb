class CabcajasController < ApplicationController
  before_filter :login_required
  access_control  [:buscarcaja, :bajarcaja] => '(rol 5 | rol 6 | rol 7)'

  # GET /cabcajas
  # GET /cabcajas.xml
  def index
    @cabcajas = Cabcaja.all
    @cajas = Cabasiento.cajas()
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabcajas }
    end
  end

  # GET /cabcajas/1
  # GET /cabcajas/1.xml
  def show
    @cabcaja = Cabcaja.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabcaja }
    end
  end

  # GET /cabcajas/new
  # GET /cabcajas/new.xml
  def new
    @cabcaja = Cabcaja.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabcaja }
    end
  end

  # GET /cabcajas/1/edit
  def edit
    @cabcaja = Cabcaja.find(params[:id])
  end

  # POST /cabcajas
  # POST /cabcajas.xml
  def create
    @cabcaja = Cabcaja.new(params[:cabcaja])

    respond_to do |format|
      if @cabcaja.save
        flash[:notice] = 'Cabcaja was successfully created.'
        format.html { redirect_to(@cabcaja) }
        format.xml  { render :xml => @cabcaja, :status => :created, :location => @cabcaja }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cabcaja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cabcajas/1
  # PUT /cabcajas/1.xml
  def update
    @cabcaja = Cabcaja.find(params[:id])

    respond_to do |format|
      if @cabcaja.update_attributes(params[:cabcaja])
        flash[:notice] = 'Cabcaja was successfully updated.'
        format.html { redirect_to(@cabcaja) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabcaja.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabcajas/1
  # DELETE /cabcajas/1.xml
  def destroy
    @cabcaja = Cabcaja.find(params[:id])
    @cabcaja.destroy

    respond_to do |format|
      format.html { redirect_to(cabcajas_url) }
      format.xml  { head :ok }
    end
  end

  # Buscar cajas de ingresos pendiendes de bajar 
  
  def buscarcaja
    @cajas = Cabcaja.cajas()

    respond_to do |format|
      format.html 
      format.xml  { render xml => @cajas } 
    end
  end

  # Bajar caja seleccionada y confeccionar asientos
  
  def bajarcaja
    @cabasientomodelo = Cabasientomodelo.find(:all, :conditions => ["casim_tipoasiento = 'Caja Ingresos'"] )
    @renasientomodelo = Renasientomodelo.find(:all, :conditions => ["cabasientomodelo_id = ?",@cabasientomodelo.id])
    @cabcaja = Cabcaja.find(params[:id])
    sucursalid = @cabcaja.id[1]
    cabcajaid  = @cabcaja.id[0]

    @renasientomodelo.each do |ren|

      if ren.rasim_metodo = 'CONTADODIR'
         @contadodir = Cabcaja.contado(sucursalid, cabcajaid, 'D')
      end
      if ren.rasim_metodo = 'CONTADOMAR'
         @contadomar = Cabcaja.contado(sucursalid, cabcajaid, 'M')
      end
      if ren.rasim_metodo = 'CONTADOFYM'
         @contadofym = Cabcaja.contado(sucursalid, cabcajaid, 'F')
      end
      if ren.rasim_metodo = 'CONTADOBSU'
         @contadobsu = Cabcaja.contado(sucursalid, cabcajaid, 'U')
      end
    end

    respond_to do |format|
      format.html 
      format.xml  { render xml => @cajas } 
    end
  end

end
