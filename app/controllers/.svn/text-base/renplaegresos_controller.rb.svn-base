class RenplaegresosController < ApplicationController
  # GET /renplaegresos
  # GET /renplaegresos.xml
  def index
    @renplaegresos = Renplaegreso.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @renplaegresos }
    end
  end

  # GET /renplaegresos/1
  # GET /renplaegresos/1.xml
  def show
    @renplaegreso = Renplaegreso.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @renplaegreso }
    end
  end

  # GET /renplaegresos/new
  # GET /renplaegresos/new.xml
  def new
    @renplaegreso = Renplaegreso.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @renplaegreso }
    end
  end

  # GET /renplaegresos/1/edit
  def edit
    @renplaegreso = Renplaegreso.find(params[:id])
  end

  # POST /renplaegresos
  # POST /renplaegresos.xml
  def create
    @renplaegreso = Renplaegreso.new(params[:renplaegreso])

    respond_to do |format|
      if @renplaegreso.save
        flash[:notice] = 'Renplaegreso was successfully created.'
        format.html { redirect_to(@renplaegreso) }
        format.xml  { render :xml => @renplaegreso, :status => :created, :location => @renplaegreso }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @renplaegreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /renplaegresos/1
  # PUT /renplaegresos/1.xml
  def update
    @renplaegreso = Renplaegreso.find(params[:id])

    respond_to do |format|
      if @renplaegreso.update_attributes(params[:renplaegreso])
        flash[:notice] = 'Renplaegreso was successfully updated.'
        format.html { redirect_to(@renplaegreso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @renplaegreso.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /renplaegresos/1
  # DELETE /renplaegresos/1.xml
  def destroy
    @renplaegreso = Renplaegreso.find(params[:id])
    @renplaegreso.destroy

    respond_to do |format|
      format.html { redirect_to(renplaegresos_url) }
      format.xml  { head :ok }
    end
  end
end
