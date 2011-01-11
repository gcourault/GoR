require 'digest/sha1'

class Usuario < ActiveRecord::Base
attr_protected :id, :salt
has_and_belongs_to_many :roles
belongs_to :sucursal
belongs_to :cliente

validates_presence_of :usur_usuario, :usur_contrasena, :usur_nivelmenu, :usur_nivel
validates_uniqueness_of :usur_usuario, :on => :create
#validates_format_of :usur_email, :with => %r{^(?:[_a-z0-9-]+)(\.[_a-z0-9-]+)*@([a-z0-9-]+)(\.[a-zA-Z0-9\-\.]+)*(\.[a-z]{2,4})$}i



def self.authenticate(login, pass)
    u=find(:first, :conditions=>["usur_usuario = ?", login])
    return nil if u.nil?
    s1 = Digest::SHA1.hexdigest(pass) # encriptar en mysql con SHA1
    return u if s1 == u.usur_contrasena 
    nil
end  

def  cliente_clie_razonsocial
#  cliente.clie_razonsocial if cliente
end

def cliente_clie_razonsocial=(clie_razonsocial, sucursal_id)
 # self.cliente = Cliente.find_by_clie_razonsocial(clie_razonsocial) unless clie_razonsocial.blank?
end

end

