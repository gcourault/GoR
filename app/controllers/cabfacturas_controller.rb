class CabfacturasController < ApplicationController
  # GET /cabfacturas
  # GET /cabfacturas.xml
#  def index
#    @cabfacturas = Cabfactura.all

#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @cabfacturas }
#    end
#  end
def index
@cabfacturas = Cabfactura.find_by_id(400)
if params[:sucursal_id].blank?
      @clientes = Cliente.find(:all,
                          :conditions => ['clie_razonsocial LIKE ?', "%#{params[:search]}%"])
    else
      @clientes = Cliente.find(:all,
                  :conditions => ['clie_razonsocial LIKE ? and sucursal_id = ?', "%#{params[:search]}%", "#{params[:sucursal_id]}" ])
    end
 
    respond_to do |format|
      format.html # index.html.erb
   #   format.xml  { render <img src="http://kresimirbojcic.com/wp-includes/images/smilies/icon_mad.gif" alt=":x" class="wp-smiley"> ml => @clientes }
      format.js
    end
end
  # GET /cabfacturas/1
  # GET /cabfacturas/1.xml
  def show
    @cabfactura = Cabfactura.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cabfactura }
    end
  end

  # GET /cabfacturas/new
  # GET /cabfacturas/new.xml
  def new
    @cabfactura = Cabfactura.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cabfactura }
    end
  end

  # GET /cabfacturas/1/edit
  def edit
    @cabfactura = Cabfactura.find(params[:id])
  end

  # POST /cabfacturas
  # POST /cabfacturas.xml
  def create
    @cabfactura = Cabfactura.new(params[:cabfactura])

    respond_to do |format|
      if @cabfactura.save
        flash[:notice] = 'Cabfactura was successfully created.'
        format.html { redirect_to(@cabfactura) }
        format.xml  { render :xml => @cabfactura, :status => :created, :location => @cabfactura }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cabfactura.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /cabfacturas/1
  # PUT /cabfacturas/1.xml
  def update
    @cabfactura = Cabfactura.find(params[:id])

    respond_to do |format|
      if @cabfactura.update_attributes(params[:cabfactura])
        flash[:notice] = 'Cabfactura was successfully updated.'
        format.html { redirect_to(@cabfactura) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cabfactura.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /cabfacturas/1
  # DELETE /cabfacturas/1.xml
  def destroy
    @cabfactura = Cabfactura.find(params[:id])
    @cabfactura.destroy

    respond_to do |format|
      format.html { redirect_to(cabfacturas_url) }
      format.xml  { head :ok }
    end
  end
end
