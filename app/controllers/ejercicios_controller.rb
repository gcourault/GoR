class EjerciciosController < ApplicationController
  # GET /ejercicios
  # GET /ejercicios.xml
  def index
    @ejercicios = Ejercicio.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ejercicios }
    end
  end

  # GET /ejercicios/1
  # GET /ejercicios/1.xml
  def show
    @ejercicio = Ejercicio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ejercicio }
    end
  end

  # GET /ejercicios/new
  # GET /ejercicios/new.xml
  def new
    @ejercicio = Ejercicio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ejercicio }
    end
  end

  # GET /ejercicios/1/edit
  def edit
    @ejercicio = Ejercicio.find(params[:id])
  end

  # POST /ejercicios
  # POST /ejercicios.xml
  def create
    @ejercicio = Ejercicio.new(params[:ejercicio])

    respond_to do |format|
      if @ejercicio.save
        flash[:notice] = 'Ejercicio was successfully created.'
        format.html { redirect_to(@ejercicio) }
        format.xml  { render :xml => @ejercicio, :status => :created, :location => @ejercicio }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ejercicio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ejercicios/1
  # PUT /ejercicios/1.xml
  def update
    @ejercicio = Ejercicio.find(params[:id])

    respond_to do |format|
      if @ejercicio.update_attributes(params[:ejercicio])
        flash[:notice] = 'Ejercicio was successfully updated.'
        format.html { redirect_to(@ejercicio) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ejercicio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ejercicios/1
  # DELETE /ejercicios/1.xml
  def destroy
    @ejercicio = Ejercicio.find(params[:id])
    @ejercicio.destroy

    respond_to do |format|
      format.html { redirect_to(ejercicios_url) }
      format.xml  { head :ok }
    end
  end
end
