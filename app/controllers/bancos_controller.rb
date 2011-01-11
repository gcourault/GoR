require 'rubygems'
# require 'gruff'

class BancosController < ApplicationController

  def index
    # GET /bancos
    # /bancos.xml
    @bancos = Banco.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bancos }
    end
  end

  def show
    @banco = Banco.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @banco }
    end
  end

  def new
    @banco = Banco.new
    respond_to do |format|
      format.html { render :action => "new", :layout => false }
      format.xml { render :xml => @banco }
    end
  end

  def edit
    @banco = Banco.find(params[:id])
  end

 def create
    @banco = Banco.new(params[:banco])

    respond_to do |format|
      if @banco.save
        flash[:notice] = 'El nuevo banco a sido creado exitosamente.'
        format.html { redirect_to(@banco) }
        format.xml  { render :xml => @banco, :status => :created, :location => @banco }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @banco.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @banco = Banco.find(params[:id])

    respond_to do |format|
      if @banco.update_attributes(params[:banco])
        flash[:notice] = 'El banco a sido modificado exitosamente.'
        format.html { redirect_to(@banco) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @banco.errors, :status => :unprocessable_entity }
      end
    end
  end


end
