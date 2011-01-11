class CabremitosController < ApplicationController
  # GET /cabremitos
  # GET /cabremitos.xml
  

  def index
    @subsection = "cabremitos"
    conditions = params[:cliente_id].nil? ? nil : ["cliente_id = ?", params[:cliente_id]]
     render :action => "cabremitos_list"
  end

  def new
    @subsection = "cabremitos_form"
    @clientes = Cliente.find(:all)
    
    if @clientes.length == 0
      flash[:notice] = "No hay ningún cliente dado de alta"
      render :template => "error"
    else
      @cabremitos = Cabremito.new
      render :action => "cabremito_form"
    end
  end
  
  # show
  #
  def show
      @cabremitos = Cabremito.find(params[:id])
  #  html = render_to_string :template => "./pdf_cabremitos.html.erb", :layout => false
    
    respond_to do |format|
      
    
    end
  end
  
  # create
  #
  def create
    
    @subsection = "cabremitos_form"
    
    @cabremito = Cabremito.new(params[:invoice])
    @cabremito.cliente = @cliente = Cliente.find(params[:cabremito][:cliente_id])
    @clientes = Cliente.find(:all)
    
    
    if @cabremito.save
      redirect_to edit_cabremito_path(@cabremito)
    else
      render :action => "cabremito_form"
    end
  end
  
  # edit
  #
  def edit
    @cabremito = Cabremito.find(params[:id], :include => :cliente)
    @cliente = @cabremito.cliente
    @renremito = Renremito.new
    
    
    @clientes = Cliente.find(:all)
    
    respond_to do |format|
      format.html { render :action => "cabremito_form" }
    end
  end
  
  # update
  #
  def update
    @cabremito = Cabremito.find(params[:id])
    
    if @cabremito.update_attributes(params[:cabremito])
      redirect_to edit_cabremito_path(@cabremito)
    else
      @clientes = Cliente.find(:all)
      @renremito = Renremito.new

      render :action => "cabremito_form"
    end
    
  rescue
     redirect_to edit_cabremito_url(@cabremito)
  end
  
  # destroy
  #
  def destroy
    Cabremito.delete(params[:id])

    redirect_to cabremitos_path
  end
  
  
  # public_invoices
  #
  def public_cabremitos
    
    @cliente = Cliente.find(params[:cliente_id], :include => :cabremitos)
    
    # check customer's private key
    
    if @cliente.private_key != params[:private_key]
      render :nothing => true
      return
    end
    
    respond_to do |format|
      format.html { render :layout => false }
      format.xml { render :xml => @cliente.cabremitos.to_xml(:include => :renremitos) }
    end
  end
  
  # search
  #
  def search
    @subsection = "cabremitos"

    init_date = parse_date(params[:init_date])
    end_date = parse_date(params[:end_date])
    
    @cabremitos = Cabremito.find(:all, :conditions => ["crem_fecha BETWEEN ? AND ?", init_date, end_date])
   # @total = @invoices.accumulate(:base, :total_irpf, :total_iva, :total)
       
    respond_to do |format|
      format.html { render :action => "search_results" }
    end
  end
 
  private
  # get_customer
  #
  def get_cliente
    @cliente = Cliente.find(params[:cliente_id]) if params[:cliente_id]
  end
  
  def parse_date(date)
    if date =~ /(\d{1,2})\/(\d{1,2})\/(\d{4})/
      "#{$3}-#{$2}-#{$1}"
    end
  end
  
  # set_section
  #
  def set_section
    @section = "cabremitos"
  end
end
