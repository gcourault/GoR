class StocksController < ApplicationController
   before_filter :login_required
   access_control [:consultastock, :mostrar] => '(rol 6 | rol 7)'

 def permission_denied
    flash[:notice] = "Usted no tiene permiso para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
 end

  # GET /stocks
  # GET /stocks.xml
  def consultastock
    #@stocks = Stock.all
   if (!params[:modelo].blank? || !params[:medida].blank?)
       @articulos = Stock.buscapormodelo(params[:modelo], params[:medida]) 
   else
     @articulos = Stock.search(params[:marcacod] , params[:rubrocod],  params[:codigo])
   end
    respond_to do |format|

      format.html # index.html.erb
      format.xml  { render :xml => @stocks }
    end
  end
  
 def mostrar
  @articulo = Articulo.find(params[:id])
  @stocks = Stock.traeunidades(params[:id]) 
 end
 
 def stock
    @articulo = Articulo.find(params[:id])
    @stocks = Stock.traeunidades(params[:id]) 
    render :partial => 'stocks/stock', :object => @articulo 
 end
 
end
