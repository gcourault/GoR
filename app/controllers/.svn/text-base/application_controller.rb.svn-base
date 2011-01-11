# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :login_required
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  # layout 'standard'
  
  def render_to_pdf(options = nil)
    data = render_to_string(options)
    pdf = PDF::HTMLDoc.new
    pdf.set_option :bodycolor, :white
    pdf.set_option :toc, false
    pdf.set_option :portrait, true
    pdf.set_option :links, false
    pdf.set_option :webpage, true
    pdf.set_option :left, '2cm'
    pdf.set_option :right, '2cm'
    pdf << data
    pdf.generate
  end

  #login
  def login_required
    if session[:user]
      return true
    end
    flash[:warning] = 'Por favor loguese para continuar'
    session[:return_to] = request.request_uri
    redirect_to :controller => "login", :action => "login"
    return false 
  end

  def current_user
    @current_user ||= ((session[:user] && Usuario.find_by_id(session[:user])) || nil)
  end

  def redirect_to_stored
    if return_to = session[:return_to]
      session[:return_to] = nil
      redirect_to_url(return_to)
    else
      redirect_to :controller => 'login', :action => 'welcome'
    end
  end

  # Conversion de fechas dedicada a Gustavo y Carlitos
  def convierte_fecha(obj)
    begin
      return Date.civil(obj ['year'].to_i, obj ['month'].to_i, obj ['day'].to_i)
    rescue ArgumentError
      false
    end
  end


  #para el manejo de excepciones
  #def rescue_action_in_public(exception)
  #	case(exception)
  #	   when ActiveRecord::RecordNotFound then render :file => '/error_record'
  #	   when NoMethodError then render :file => '/no_method'
  #	else render :file => RAILS_ROOT + '/public/404.html'
  #	end
  #end



end

