class RubrosController < ApplicationController

  before_filter :login_required
  access_control [:index, :list, :new, :create, :update, :edit, :show] => '(rol 4| rol 5| rol 6 | rol 7 )'

  # GET /rubros
  # GET /rubros.xml
  def index
    @rubros = Rubro.paginate(:per_page => 15, :page => params[:page] || 1, :order => ['rubr_codigo'])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rubros }
    end
  end

  # GET /rubros/1
  # GET /rubros/1.xml
  def show
    @rubro = Rubro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rubro }
    end
  end

  # GET /rubros/new
  # GET /rubros/new.xml
  def new
    @rubro = Rubro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rubro }
    end
  end

  # GET /rubros/1/edit
  def edit
    @rubro = Rubro.find(params[:id])
  end

  # POST /rubros
  # POST /rubros.xml
  def create
    @rubro = Rubro.new(params[:rubro])
    @rubro.rubr_ultmod  = DateTime.now
    @rubro.rubr_usuario = session[:user].usur_nombre

    respond_to do |format|
      if @rubro.save
        flash[:notice] = 'El Rubro nuevo fue guardado.'
        format.html { redirect_to(:controller => 'rubros' , :action => 'index' ) }
        format.xml  { render :xml => @rubro, :status => :created, :location => @rubro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /rubros/1
  # PUT /rubros/1.xml
  def update
    @rubro = Rubro.find(params[:id])

    respond_to do |format|
      if @rubro.update_attributes(params[:rubro])
        flash[:notice] = 'El rubro ha sido modificado.'
        pag = params[:page]
        format.html { redirect_to(:controller => 'rubros', :action => 'index', :page => pag ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rubro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rubros/1
  # DELETE /rubros/1.xml
  def destroy
    @rubro = Rubro.find(params[:id])
    @rubro.destroy

    respond_to do |format|
      format.html { redirect_to(rubros_url) }
      format.xml  { head :ok }
    end
  end
end
