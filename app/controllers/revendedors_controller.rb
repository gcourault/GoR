class RevendedorsController < ApplicationController
  # GET /revendedors
  # GET /revendedors.xml
  def index
    @revendedors = Revendedor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @revendedors }
    end
  end

  # GET /revendedors/1
  # GET /revendedors/1.xml
  def show
    @revendedor = Revendedor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @revendedor }
    end
  end

  # GET /revendedors/new
  # GET /revendedors/new.xml
  def new
    @revendedor = Revendedor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @revendedor }
    end
  end

  # GET /revendedors/1/edit
  def edit
    @revendedor = Revendedor.find(params[:id])
  end

  # POST /revendedors
  # POST /revendedors.xml
  def create
    @revendedor = Revendedor.new(params[:revendedor])

    respond_to do |format|
      if @revendedor.save
        flash[:notice] = 'Revendedor was successfully created.'
        format.html { redirect_to(@revendedor) }
        format.xml  { render :xml => @revendedor, :status => :created, :location => @revendedor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @revendedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /revendedors/1
  # PUT /revendedors/1.xml
  def update
    @revendedor = Revendedor.find(params[:id])

    respond_to do |format|
      if @revendedor.update_attributes(params[:revendedor])
        flash[:notice] = 'Revendedor was successfully updated.'
        format.html { redirect_to(@revendedor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @revendedor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /revendedors/1
  # DELETE /revendedors/1.xml
  def destroy
    @revendedor = Revendedor.find(params[:id])
    @revendedor.destroy

    respond_to do |format|
      format.html { redirect_to(revendedors_url) }
      format.xml  { head :ok }
    end
  end
end
