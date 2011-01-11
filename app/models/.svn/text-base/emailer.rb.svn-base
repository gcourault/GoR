class Emailer < ActionMailer::Base
   def email_template(idcabpedidoweb, sucursalemail, clienteemail, cliente, cuit, clientecodigo,  sent_at = Time.now)
      @idcabpedidoweb = idcabpedidoweb
      @cliente = cliente
      @cuit = cuit
      @clientecodigo = clientecodigo
      @subject =  "Pedido"
      @recipients = "#{sucursalemail}, #{clienteemail}"
      @from = "Fleming y Martolio ventas@flemingymartolio.com.ar"
      @sent_on = sent_at
   end
end
