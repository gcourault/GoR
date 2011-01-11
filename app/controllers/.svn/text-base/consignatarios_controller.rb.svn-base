class ConsignatariosController < ApplicationController
  # GET /consignatarios
  # GET /consignatarios.xml
  def index
    @consignatarios = Consignatario.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @consignatarios }
    end
  end

  # GET /consignatarios/1
  # GET /consignatarios/1.xml
  def show
    @consignatario = Consignatario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @consignatario }
    end
  end

  # GET /consignatarios/new
  # GET /consignatarios/new.xml
  def new
    @consignatario = Consignatario.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @consignatario }
    end
  end

  # GET /consignatarios/1/edit
  def edit
    @consignatario = Consignatario.find(params[:id])
  end

  # POST /consignatarios
  # POST /consignatarios.xml
  def create
    @consignatario = Consignatario.new(params[:consignatario])

    respond_to do |format|
      if @consignatario.save
        flash[:notice] = 'Consignatario was successfully created.'
        format.html { redirect_to(@consignatario) }
        format.xml  { render :xml => @consignatario, :status => :created, :location => @consignatario }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @consignatario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /consignatarios/1
  # PUT /consignatarios/1.xml
  def update
    @consignatario = Consignatario.find(params[:id])

    respond_to do |format|
      if @consignatario.update_attributes(params[:consignatario])
        flash[:notice] = 'Consignatario was successfully updated.'
        format.html { redirect_to(@consignatario) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @consignatario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /consignatarios/1
  # DELETE /consignatarios/1.xml
  def destroy
    @consignatario = Consignatario.find(params[:id])
    @consignatario.destroy

    respond_to do |format|
      format.html { redirect_to(consignatarios_url) }
      format.xml  { head :ok }
    end
  end
end
