class Maestrolista < ActiveRecord::Base
has_many  :listaprecio

#validates_presence_of :mlis_nrolistaorigen
validates_numericality_of :mlis_nrolistaorigen, :only_integer => true, :message => "Debe ingresar el numero de la lista de precio origen"
 #valición del campo nombre que sean solo letras
 validates_format_of :mlis_nombre,
                      :with => /[a-zA-Z]/,
                      :message => "No válido, solo se pueden ingresar letras."

def self.crealista(maestroidorig, maestroidnuevo)

   sqllistaprecio = "Insert into listaprecios  Select 0, 0, pla.lpre_codigolista, pla.articulo_id, pla.lpre_preciolista, pla.lpre_preciocosto,    			     pla.lpre_precioventa, pla.lpre_remarque, pla.lpre_remarque2, pla.lpre_remarque3, pla.id, pla.lpre_porcprovisorio, 			     pla.lpre_usuario, pla.lpre_ultmod, #{maestroidnuevo} From listaprecios as pla where pla.maestrolista_id = #{maestroidorig}"
    
    ActiveRecord::Base.connection.execute( sqllistaprecio )
    # Generar los registros de las grillas
    sqlgrillalista = "insert into grillalistas
                      (listaprecio_id, maestrolista_id, glis_nrogrilla, glis_nrocolumna, glis_porcentaje )
                      select gl.listaprecio_id, #{maestroidnuevo},
                      gl.glis_nrogrilla, gl.glis_nrocolumna, gl.glis_porcentaje
                      from grillalistas as gl where gl.maestrolista_id = #{maestroidorig} "
    ActiveRecord::Base.connection.execute( sqlgrillalista )

    # Copiar los id_nuevos a la grillalista

    sqlactualizaid = "update grillalistas as gl, listaprecios as lp
                  set gl.listaprecio_id = lp.id 
                  where gl.listaprecio_id = lp.lpre_idlpreanterior 
                  and gl.maestrolista_id = #{maestroidnuevo} 
                  and lp.maestrolista_id = #{maestroidnuevo}" 
    ActiveRecord::Base.connection.execute( sqlactualizaid )
end

def self.descuentolista(nrolista, nrolistaorig, maestroidnuevo)
	sqldescuentolista = "insert into descuentolista     (id_descuentolista,desc_nrolista,maestrolista_id,desc_nrocolumna,id_articulo,desc_porcentaje,desc_titulo,desc_tipocond,desc_usuario,desc_ultmod)
select 0, #{nrolista},#{maestroidnuevo},dl.desc_nrocolumna,dl.id_articulo,dl.desc_porcentaje,dl.desc_titulo,dl.desc_tipocond,dl.desc_usuario,now()
from descuentolista as dl where desc_nrolista =  #{nrolistaorig}"
	ActiveRecord::Base.connection.execute( sqldescuentolista )
end

end

       
