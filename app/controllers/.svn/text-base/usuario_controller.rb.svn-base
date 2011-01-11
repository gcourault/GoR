require 'rubygems'
# require 'gruff'

class UsuarioController < ApplicationController
 before_filter :login_required, :only=>['welcome']
    def signup
     @user = Usuario.new(@params[:user])
     if request.post?  
      if @user.save
        session[:user] = Usuario.authenticate(@user.login, @user.password)
        flash[:message] = "Logueado correctamente!"
        redirect_to :action => "welcome"          
      else
        flash[:warning] = "Signup unsuccessful"
      end
    end
  end

  def login
     if request.post?
      if session[:user] = Usuario.authenticate(params[:user][:login], params[:user][:password])
        flash[:message]  = "Su autentificación se realizo correctamente!"
        session[:sucursalseleccionada] = 1
       #redirect_to_stored
        redirect_to  :action => 'iniciarsession'
       # redirect_to "http://localhost:3000/"
      else
        flash[:warning] = "Nombre de usuario o contraseña incorrecta."
      end
    end
  end

  def logout
    session[:user] = nil
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
