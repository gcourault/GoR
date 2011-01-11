class Rg1361afipsController < ApplicationController
   before_filter :login_required
   access_control [:index, :busqueda, :fechas] => '(rol5 | rol 6 | rol 7 )'
                 
  def permission_denied
    flash[:notice] = "Usted no tiene los privilegios para realizar esta acción." 
    return redirect_to(:controller => 'login', :action => 'denied')
  end
  # GET /rg1361afips
  # GET /rg1361afips.xml
   def fechas
    if params[:fecha].blank?
      else
        params[:fecha] = convierte_fecha(params[:fecha])
    end
  end

  def index
  end

  def busqueda
    fechas()
    @rg1361afipcabs = Rg1361afip.consultacab(params[:fecha])
    @cantidadrengs = Rg1361afip.cantidadreng(params[:fecha])
    @rg1361afipcabcompras = Rg1361afip.consultacabcompra(params[:fecha])
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rg1361afips }
    end
  end

  
end
