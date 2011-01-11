class EstadochetersController < ApplicationController
  # GET /estadocheters
  # GET /estadocheters.xml
  def index
    @estadocheters = Estadocheter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estadocheters }
    end
  end

  # GET /estadocheters/1
  # GET /estadocheters/1.xml
  def show
    @estadocheter = Estadocheter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estadocheter }
    end
  end

  # GET /estadocheters/new
  # GET /estadocheters/new.xml
  def new
    @estadocheter = Estadocheter.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estadocheter }
    end
  end

  # GET /estadocheters/1/edit
  def edit
    @estadocheter = Estadocheter.find(params[:id])
  end

  # POST /estadocheters
  # POST /estadocheters.xml
  def create
    @estadocheter = Estadocheter.new(params[:estadocheter])

    respond_to do |format|
      if @estadocheter.save
        flash[:notice] = 'Estadocheter was successfully created.'
        format.html { redirect_to(@estadocheter) }
        format.xml  { render :xml => @estadocheter, :status => :created, :location => @estadocheter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @estadocheter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estadocheters/1
  # PUT /estadocheters/1.xml
  def update
    @estadocheter = Estadocheter.find(params[:id])

    respond_to do |format|
      if @estadocheter.update_attributes(params[:estadocheter])
        flash[:notice] = 'Estadocheter was successfully updated.'
        format.html { redirect_to(@estadocheter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @estadocheter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estadocheters/1
  # DELETE /estadocheters/1.xml
  def destroy
    @estadocheter = Estadocheter.find(params[:id])
    @estadocheter.destroy

    respond_to do |format|
      format.html { redirect_to(estadocheters_url) }
      format.xml  { head :ok }
    end
  end
end
