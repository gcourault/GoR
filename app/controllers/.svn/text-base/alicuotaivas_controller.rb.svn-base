class AlicuotaivasController < ApplicationController
  # GET /alicuotaivas
  # GET /alicuotaivas.xml
  def index
    @alicuotaivas = Alicuotaiva.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alicuotaivas }
    end
  end

  # GET /alicuotaivas/1
  # GET /alicuotaivas/1.xml
  def show
    @alicuotaiva = Alicuotaiva.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alicuotaiva }
    end
  end

  # GET /alicuotaivas/new
  # GET /alicuotaivas/new.xml
  def new
    @alicuotaiva = Alicuotaiva.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alicuotaiva }
    end
  end

  # GET /alicuotaivas/1/edit
  def edit
    @alicuotaiva = Alicuotaiva.find(params[:id])
  end

  # POST /alicuotaivas
  # POST /alicuotaivas.xml
  def create
    @alicuotaiva = Alicuotaiva.new(params[:alicuotaiva])

    respond_to do |format|
      if @alicuotaiva.save
        flash[:notice] = 'Alicuotaiva was successfully created.'
        format.html { redirect_to(@alicuotaiva) }
        format.xml  { render :xml => @alicuotaiva, :status => :created, :location => @alicuotaiva }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @alicuotaiva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /alicuotaivas/1
  # PUT /alicuotaivas/1.xml
  def update
    @alicuotaiva = Alicuotaiva.find(params[:id])

    respond_to do |format|
      if @alicuotaiva.update_attributes(params[:alicuotaiva])
        flash[:notice] = 'Alicuotaiva was successfully updated.'
        format.html { redirect_to(@alicuotaiva) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alicuotaiva.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alicuotaivas/1
  # DELETE /alicuotaivas/1.xml
  def destroy
    @alicuotaiva = Alicuotaiva.find(params[:id])
    @alicuotaiva.destroy

    respond_to do |format|
      format.html { redirect_to(alicuotaivas_url) }
      format.xml  { head :ok }
    end
  end
end
