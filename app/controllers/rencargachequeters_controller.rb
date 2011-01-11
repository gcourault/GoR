class RencargachequetersController < ApplicationController
  # GET /rencargachequeters
  # GET /rencargachequeters.xml
  def index
    @cabcargachequeter = Cabcargachequeter.find(params[:idcomp])

    @total = Rencargachequeter.totalcheques( params[:idcomp] , session[:sucursal] )

    @rencargachequeter = Rencargachequeter.find(:all , :conditions => ["cabcargachequeter_id = ? and sucursal_id = ?", params[:idcomp].to_i , session[:sucursal] ] , :order => 'id DESC' )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rencargachequeter }
    end
  end

  # GET /rencargachequeters/1
  # GET /rencargachequeters/1.xml
  def show
    @rencargachequeter = Rencargachequeter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rencargachequeter }
    end
  end

  # GET /rencargachequeters/new
  # GET /rencargachequeters/new.xml
  def new
    @rencargachequeter = Rencargachequeter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rencargachequeter }
    end
  end

  # GET /rencargachequeters/1/edit
  def edit
    @rencargachequeter = Rencargachequeter.find(params[:id])
  end

  # POST /rencargachequeters
  # POST /rencargachequeters.xml
  def create
    @rencargachequeter = Rencargachequeter.new(params[:rencargachequeter])

    respond_to do |format|
      if @rencargachequeter.save
        flash[:notice] = 'Rencargachequeter was successfully created.'
        format.html { redirect_to(@rencargachequeter) }
        format.xml  { render :xml => @rencargachequeter, :status => :created, :location => @rencargachequeter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rencargachequeter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rencargachequeters/1
  # PUT /rencargachequeters/1.xml
  def update
    @rencargachequeter = Rencargachequeter.find(params[:id])

    respond_to do |format|
      if @rencargachequeter.update_attributes(params[:rencargachequeter])
        flash[:notice] = 'Rencargachequeter was successfully updated.'
        format.html { redirect_to(@rencargachequeter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rencargachequeter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rencargachequeters/1
  # DELETE /rencargachequeters/1.xml
  def destroy
    @rencargachequeter = Rencargachequeter.find(params[:id])
    idcomp = @rencargachequeter.cabcargachequeter_id 

    # Busco el cheque y lo borro, despues borro el renglon
    idsuc = @rencargachequeter.sucursal_id
    idcht = @rencargachequeter.chequetercero_id
    @chequetercero = Chequetercero.find(idcht , idsuc)
    @chequetercero.destroy

    # Ahora si borro el renglon
    
    @rencargachequeter.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => "rencargachequeters" , :action => "index" , :idcomp => idcomp ) }
      format.xml  { head :ok }
    end
  end
end
