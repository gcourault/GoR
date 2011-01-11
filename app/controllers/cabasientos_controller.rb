class CabasientosController < ApplicationController
  # GET /cabasientos
  # GET /cabasientos.xml
  def index
    @cabasientos = Cabasiento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @cabasientos }
    end
  end

  # GET /cabasientos/1
  # GET /cabasientos/1.xml
  def show
    @cabasiento = Cabasiento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabasiento }
    end
  end

  # GET /cabasientos/new
  # GET /cabasientos/new.xml
  def new
    @cabasiento = Cabasiento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabasiento }
    end
  end

  # GET /cabasientos/1/edit
  def edit
    @cabasiento = Cabasiento.find(params[:id])
  end

  # POST /cabasientos
  # POST /cabasientos.xml
  def create
    @cabasiento = Cabasiento.new(params[:cabasiento])

    respond_to do |format|
      if @cabasiento.save
        flash[:notice] = 'Cabasiento was successfully created.'
        format.html { redirect_to(@cabasiento) }
        format.xml  { render :xml => @cabasiento, :status => :created, :location => @cabasiento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cabasiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cabasientos/1
  # PUT /cabasientos/1.xml
  def update
    @cabasiento = Cabasiento.find(params[:id])

    respond_to do |format|
      if @cabasiento.update_attributes(params[:cabasiento])
        flash[:notice] = 'Cabasiento was successfully updated.'
        format.html { redirect_to(@cabasiento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabasiento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabasientos/1
  # DELETE /cabasientos/1.xml
  def destroy
    @cabasiento = Cabasiento.find(params[:id])
    @cabasiento.destroy

    respond_to do |format|
      format.html { redirect_to(cabasientos_url) }
      format.xml  { head :ok }
    end
  end
end
