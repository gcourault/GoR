class RenasientosController < ApplicationController
  # GET /renasientos
  # GET /renasientos.xml
  def index
    @renasientos = Renasiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @renasientos }
    end
  end

  # GET /renasientos/1
  # GET /renasientos/1.xml
  def show
    @renasiento = Renasiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @renasiento }
    end
  end

  # GET /renasientos/new
  # GET /renasientos/new.xml
  def new
    @renasiento = Renasiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @renasiento }
    end
  end

  # GET /renasientos/1/edit
  def edit
    @renasiento = Renasiento.find(params[:id])
  end

  # POST /renasientos
  # POST /renasientos.xml
  def create
    @renasiento = Renasiento.new(params[:renasiento])

    respond_to do |format|
      if @renasiento.save
        flash[:notice] = 'Renasiento was successfully created.'
        format.html { redirect_to(@renasiento) }
        format.xml  { render :xml => @renasiento, :status => :created, :location => @renasiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @renasiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /renasientos/1
  # PUT /renasientos/1.xml
  def update
    @renasiento = Renasiento.find(params[:id])

    respond_to do |format|
      if @renasiento.update_attributes(params[:renasiento])
        flash[:notice] = 'Renasiento was successfully updated.'
        format.html { redirect_to(@renasiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @renasiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /renasientos/1
  # DELETE /renasientos/1.xml
  def destroy
    @renasiento = Renasiento.find(params[:id])
    @renasiento.destroy

    respond_to do |format|
      format.html { redirect_to(renasientos_url) }
      format.xml  { head :ok }
    end
  end
end
