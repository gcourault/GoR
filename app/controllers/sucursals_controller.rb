class SucursalsController < ApplicationController
  # GET /sucursals
  # GET /sucursals.xml
  def index
    @sucursals = Sucursal.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sucursals }
    end
  end

  # GET /sucursals/1
  # GET /sucursals/1.xml
  def show
    @sucursal = Sucursal.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sucursal }
    end
  end

  # GET /sucursals/new
  # GET /sucursals/new.xml
  def new
    @sucursal = Sucursal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sucursal }
    end
  end

  # GET /sucursals/1/edit
  def edit
    @sucursal = Sucursal.find(params[:id])
  end

  # POST /sucursals
  # POST /sucursals.xml
  def create
    @sucursal = Sucursal.new(params[:sucursal])

    respond_to do |format|
      if @sucursal.save
        flash[:notice] = 'Sucursal was successfully created.'
        format.html { redirect_to(@sucursal) }
        format.xml  { render :xml => @sucursal, :status => :created, :location => @sucursal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sucursal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sucursals/1
  # PUT /sucursals/1.xml
  def update
    @sucursal = Sucursal.find(params[:id])

    respond_to do |format|
      if @sucursal.update_attributes(params[:sucursal])
        flash[:notice] = 'Sucursal was successfully updated.'
        format.html { redirect_to(@sucursal) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sucursal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sucursals/1
  # DELETE /sucursals/1.xml
  def destroy
    @sucursal = Sucursal.find(params[:id])
    @sucursal.destroy

    respond_to do |format|
      format.html { redirect_to(sucursals_url) }
      format.xml  { head :ok }
    end
  end
end
