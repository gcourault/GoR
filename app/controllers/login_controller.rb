require 'rubygems'

class LoginController < ApplicationController
 before_filter :login_required, :only=>['welcome']


 def signup
     @user = Usuario.new(@params[:user])
     if request.post?  
      if @user.save
        session[:user] = Usuario.authenticate(@user.login, @user.password)
        flash[:message] = "Logueado correctamente!"
        redirect_to :action => "welcome"          
      else
        flash[:warning] = "Error en la autentificación"
      end
    end
  end

  def login
     if request.post?
      if session[:user] = Usuario.authenticate(params[:user][:login], params[:user][:password])
        @empresa = Empresa.find(:first) #cargar la sucursal
        session[:sucursal] = @empresa.sucursal_id
        session[:sucursalseleccionada] = @empresa.sucursal_id
        flash[:message]  = "Su autentificación se realizo correctamente!"
       #redirect_to_stored
        redirect_to  :action => 'iniciarsession'
       # redirect_to "http://localhost:3000/"
      else
       render :partial => "error", :layout => "application"
      end
    end
  end

  def logout
    session[:user] = nil
    session[:sucursal] = nil
    session[:sucursalseleccionada] = nil
    flash[:message] = 'Cerrar session'
    redirect_to :action => 'cerrarsession'
  end


 def welcome
  redirect_to :action => 'iniciarsession'
  #redirect_to "http://localhost:3000/"
 end

def iniciarsession
end

def denied
end

def cerrarsession
end
end