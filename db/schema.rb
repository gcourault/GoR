# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101110181949) do

  create_table "alicuotaiva", :primary_key => "id_alicuotaiva", :force => true do |t|
    t.float  "aiva_alicuota", :limit => 5, :default => 0.0, :null => false
    t.date   "aiva_inicio",                                 :null => false
    t.date   "aiva_final",                                  :null => false
    t.string "aiva_usuario",  :limit => 8, :default => "",  :null => false
    t.date   "aiva_ultmod",                                 :null => false
  end

  create_table "alicuotaivas", :id => false, :force => true do |t|
    t.integer "id",            :limit => 1, :default => 0,   :null => false
    t.float   "aiva_alicuota", :limit => 5, :default => 0.0, :null => false
    t.date    "aiva_inicio",                                 :null => false
    t.date    "aiva_final",                                  :null => false
    t.string  "aiva_usuario",  :limit => 8, :default => "",  :null => false
    t.date    "aiva_ultmod",                                 :null => false
  end

  create_table "articulo", :primary_key => "id_articulo", :force => true do |t|
    t.integer "arti_codigo",                                  :default => 0,   :null => false
    t.string  "arti_codigoviejo",     :limit => 10,           :default => "0"
    t.string  "arti_descripcion",     :limit => 50,           :default => "",  :null => false
    t.integer "id_marca",             :limit => 1,            :default => 0,   :null => false
    t.integer "id_rubro",             :limit => 1,            :default => 0,   :null => false
    t.string  "arti_modelo",          :limit => 20,           :default => "",  :null => false
    t.string  "arti_medida",          :limit => 25,           :default => "",  :null => false
    t.string  "arti_conosincamara",   :limit => 2,            :default => "",  :null => false
    t.integer "arti_telas",           :limit => 1,            :default => 0
    t.string  "arti_clavesecundaria", :limit => 15
    t.integer "id_alicuotaiva",       :limit => 1,            :default => 0,   :null => false
    t.enum    "arti_codigolista",     :limit => [:C, :I, :T], :default => :C,  :null => false
    t.enum    "arti_impnac",          :limit => [:I, :N],     :default => :I,  :null => false
    t.enum    "arti_ventactaord",     :limit => [:S, :N],     :default => :S,  :null => false
    t.enum    "arti_habilitado",      :limit => [:S, :N],     :default => :S,  :null => false
    t.enum    "arti_promopirelli",    :limit => [:S, :N],     :default => :N,  :null => false
    t.enum    "arti_controlastock",   :limit => [:S, :N],     :default => :S,  :null => false
    t.enum    "arti_liquidacomision", :limit => [:S, :N],     :default => :S,  :null => false
    t.date    "arti_fechabaja"
    t.integer "id_consignatario",                             :default => 0,   :null => false
    t.enum    "arti_artinuevo",       :limit => [:S, :N],     :default => :N,  :null => false
    t.string  "arti_usuario",         :limit => 8,            :default => "",  :null => false
    t.date    "arti_ultmod",                                                   :null => false
  end

  add_index "articulo", ["arti_clavesecundaria"], :name => "arti_clavesecundaria"
  add_index "articulo", ["arti_codigo"], :name => "arti_codigo", :unique => true
  add_index "articulo", ["arti_descripcion"], :name => "arti_descripcion"
  add_index "articulo", ["id_articulo"], :name => "id_articulo"
  add_index "articulo", ["id_marca", "id_rubro", "arti_modelo", "arti_medida"], :name => "indicelista"

  create_table "articulos", :id => false, :force => true do |t|
    t.integer "id",                                           :default => 0,   :null => false
    t.integer "arti_codigo",                                  :default => 0,   :null => false
    t.string  "arti_codigoviejo",     :limit => 10,           :default => "0"
    t.string  "arti_descripcion",     :limit => 50,           :default => "",  :null => false
    t.integer "marca_id",             :limit => 1,            :default => 0,   :null => false
    t.integer "rubro_id",             :limit => 1,            :default => 0,   :null => false
    t.string  "arti_modelo",          :limit => 20,           :default => "",  :null => false
    t.string  "arti_medida",          :limit => 25,           :default => "",  :null => false
    t.string  "arti_conosincamara",   :limit => 2,            :default => "",  :null => false
    t.integer "arti_telas",           :limit => 1,            :default => 0
    t.string  "arti_clavesecundaria", :limit => 15
    t.integer "alicuotaiva_id",       :limit => 1,            :default => 0,   :null => false
    t.enum    "arti_codigolista",     :limit => [:C, :I, :T], :default => :C,  :null => false
    t.enum    "arti_impnac",          :limit => [:I, :N],     :default => :I,  :null => false
    t.enum    "arti_ventactaord",     :limit => [:S, :N],     :default => :S,  :null => false
    t.enum    "arti_habilitado",      :limit => [:S, :N],     :default => :S,  :null => false
    t.enum    "arti_promopirelli",    :limit => [:S, :N],     :default => :N,  :null => false
    t.enum    "arti_controlastock",   :limit => [:S, :N],     :default => :S,  :null => false
    t.enum    "arti_liquidacomision", :limit => [:S, :N],     :default => :S,  :null => false
    t.date    "arti_fechabaja"
    t.integer "consignatario_id",                             :default => 0,   :null => false
    t.enum    "arti_artinuevo",       :limit => [:S, :N],     :default => :N,  :null => false
    t.string  "arti_usuario",         :limit => 8,            :default => "",  :null => false
    t.date    "arti_ultmod",                                                   :null => false
  end

  create_table "autos", :id => false, :force => true do |t|
    t.string  "id_autos",     :limit => 6,  :default => "", :null => false
    t.integer "id_sucursal",  :limit => 1,  :default => 0,  :null => false
    t.string  "auto_detalle", :limit => 30, :default => "", :null => false
    t.integer "id_cliente",                 :default => 0,  :null => false
    t.string  "auto_nomcli",  :limit => 30, :default => "", :null => false
    t.string  "auto_domici",  :limit => 30, :default => "", :null => false
    t.string  "auto_locali",  :limit => 20, :default => "", :null => false
    t.string  "auto_telefo",  :limit => 50, :default => "", :null => false
    t.string  "auto_mail",    :limit => 50, :default => "", :null => false
    t.string  "auto_usuario", :limit => 8,  :default => "", :null => false
    t.date    "auto_ultmod",                                :null => false
  end

  create_table "banco", :primary_key => "id_banco", :force => true do |t|
    t.integer "banc_codigo",                :default => 0,  :null => false
    t.string  "banc_nombre",  :limit => 40, :default => "", :null => false
    t.string  "banc_usuario", :limit => 8,  :default => "", :null => false
    t.date    "banc_ultmod",                                :null => false
  end

  add_index "banco", ["banc_codigo"], :name => "banc_codigo"
  add_index "banco", ["banc_nombre"], :name => "banc_nombre"

  create_table "bancos", :id => false, :force => true do |t|
    t.integer "id",                         :default => 0,  :null => false
    t.integer "banc_codigo",                :default => 0,  :null => false
    t.string  "banc_nombre",  :limit => 40, :default => "", :null => false
    t.string  "banc_usuario", :limit => 8,  :default => "", :null => false
    t.date    "banc_ultmod",                                :null => false
  end

  create_table "cabajustestock", :id => false, :force => true do |t|
    t.integer "id_sucursal",        :limit => 1,  :default => 0,  :null => false
    t.integer "id_cabajustestock",                :default => 0,  :null => false
    t.integer "id_tipocomprobante", :limit => 1,  :default => 0,  :null => false
    t.date    "caju_fecha",                                       :null => false
    t.string  "caju_confecciono",   :limit => 30, :default => "", :null => false
    t.string  "caju_motivo",        :limit => 80, :default => "", :null => false
    t.string  "caju_anulado",       :limit => 1,  :default => "", :null => false
    t.string  "caju_usuario",       :limit => 8,  :default => "", :null => false
    t.date    "caju_ultmod",                                      :null => false
  end

  create_table "cabasiento", :primary_key => "id_cabasiento", :force => true do |t|
    t.integer "id_sucursal",      :limit => 1,          :default => 0,   :null => false
    t.integer "id_cabcaja",                             :default => 0,   :null => false
    t.date    "casi_fecha",                                              :null => false
    t.enum    "casi_cerrado",     :limit => [:No, :Si], :default => :No, :null => false
    t.enum    "casi_borrado",     :limit => [:No, :Si], :default => :No, :null => false
    t.enum    "casi_importado",   :limit => [:No, :Si], :default => :No, :null => false
    t.string  "casi_descripcion", :limit => 50,         :default => "",  :null => false
    t.string  "casi_usuario",     :limit => 12,         :default => "",  :null => false
    t.date    "casi_ultmod",                                             :null => false
  end

  create_table "cabasientomodelos", :force => true do |t|
    t.enum   "casim_tipoasiento",    :limit => [:"Caja Ingresos", :"Costo Mercaderias"],                  :null => false
    t.string "casim_detalle",        :limit => 60,                                                        :null => false
    t.enum   "casim_agreganrocaja",  :limit => [:Si, :No],                               :default => :No, :null => false
    t.enum   "casim_agregasucursal", :limit => [:Si, :No],                               :default => :No, :null => false
  end

  create_table "cabasientos", :id => false, :force => true do |t|
    t.integer "id",                                     :default => 0,   :null => false
    t.integer "sucursal_id",      :limit => 1,          :default => 0,   :null => false
    t.integer "cabcaja_id",                             :default => 0,   :null => false
    t.date    "casi_fecha",                                              :null => false
    t.enum    "casi_cerrado",     :limit => [:No, :Si], :default => :No, :null => false
    t.enum    "casi_borrado",     :limit => [:No, :Si], :default => :No, :null => false
    t.enum    "casi_importado",   :limit => [:No, :Si], :default => :No, :null => false
    t.string  "casi_descripcion", :limit => 50,         :default => "",  :null => false
    t.string  "casi_usuario",     :limit => 12,         :default => "",  :null => false
    t.date    "casi_ultmod",                                             :null => false
  end

  create_table "cabcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",   :limit => 1,          :default => 0,   :null => false
    t.integer "id_cabcaja",                          :default => 0,   :null => false
    t.integer "id_vendedor",   :limit => 1,          :default => 0,   :null => false
    t.integer "ccaj_nrocaja",                        :default => 0,   :null => false
    t.date    "ccaj_fecha",                                           :null => false
    t.string  "ccaj_cerrada",  :limit => 1,          :default => "",  :null => false
    t.enum    "ccaj_importar", :limit => [:Si, :No], :default => :Si, :null => false
    t.string  "ccaj_usuario",  :limit => 8,          :default => "",  :null => false
    t.date    "ccaj_ultmod",                                          :null => false
  end

  add_index "cabcaja", ["id_sucursal", "ccaj_nrocaja"], :name => "porsucursalnumero"

  create_table "cabcajas", :id => false, :force => true do |t|
    t.integer "sucursal_id",   :limit => 1,          :default => 0,   :null => false
    t.integer "cabcaja_id",                          :default => 0,   :null => false
    t.integer "vendedor_id",   :limit => 1,          :default => 0,   :null => false
    t.integer "ccaj_nrocaja",                        :default => 0,   :null => false
    t.date    "ccaj_fecha",                                           :null => false
    t.string  "ccaj_cerrada",  :limit => 1,          :default => "",  :null => false
    t.enum    "ccaj_importar", :limit => [:Si, :No], :default => :Si, :null => false
    t.string  "ccaj_usuario",  :limit => 8,          :default => "",  :null => false
    t.date    "ccaj_ultmod",                                          :null => false
  end

  create_table "cabcargachequeters", :force => true do |t|
    t.integer "sucursal_id",  :limit => 1,                                         :default => 0,   :null => false
    t.date    "ccht_fecha"
    t.decimal "ccht_total",                         :precision => 13, :scale => 2, :default => 0.0, :null => false
    t.enum    "ccht_cerrado", :limit => [:No, :Si],                                :default => :No, :null => false
    t.enum    "ccht_anulado", :limit => [:No, :Si],                                :default => :No, :null => false
    t.string  "ccht_usuario", :limit => 8
    t.date    "ccht_ultmod"
  end

  create_table "cabcompra", :id => false, :force => true do |t|
    t.integer "id_sucursal",             :limit => 1,                                                     :default => 0,        :null => false
    t.integer "id_cabcompra",                                                                             :default => 0,        :null => false
    t.integer "id_pagocompra"
    t.integer "retencionganancia_id"
    t.date    "ccom_fecha",                                                                                                     :null => false
    t.integer "id_tipocomprobante",      :limit => 1,                                                     :default => 0,        :null => false
    t.integer "id_cabplaegreso"
    t.integer "ccom_puntosventa",                                                                         :default => 0,        :null => false
    t.integer "ccom_desdecompro",                                                                         :default => 0
    t.integer "ccom_hastacompro"
    t.integer "ccom_codigoaduana",       :limit => 1
    t.string  "ccom_codigodestinacion",  :limit => 4,                                                     :default => "IC04",   :null => false
    t.integer "ccom_nrodespacho"
    t.string  "ccom_digverdespacho",     :limit => 1,                                                     :default => "0",      :null => false
    t.integer "id_proveedor",                                                                             :default => 0,        :null => false
    t.integer "id_renplaegreso"
    t.decimal "ccom_retencioniva",                                         :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_percepcioniva",                                        :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_retencionganancia",                                    :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_retencionib",                                          :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_percepcionib",                                         :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_retencionmunicipal",                                   :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_nogravado",                                            :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_impuestointerno",                                      :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_exento",                                               :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_netogravado",                                          :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_iva",                                                  :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_total",                                                :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.string  "ccom_cai",                :limit => 14,                                                    :default => "0",      :null => false
    t.enum    "ccom_ctcc",               :limit => [:Contado, :"Cta/Cte"],                                :default => :Contado, :null => false
    t.integer "id_jurisdiccion",                                                                          :default => 0,        :null => false
    t.integer "id_conceptoegreso",                                                                                              :null => false
    t.enum    "ccom_gastocompra",        :limit => [:GASTO, :COMPRA]
    t.integer "ccom_nroplaegreso",                                                                        :default => 0,        :null => false
    t.string  "ccom_usuario",            :limit => 8,                                                     :default => "",       :null => false
    t.date    "ccom_ultmod",                                                                                                    :null => false
  end

  add_index "cabcompra", ["ccom_fecha", "id_tipocomprobante", "ccom_puntosventa", "ccom_desdecompro"], :name => "por_fechacompro"

  create_table "cabcompras", :id => false, :force => true do |t|
    t.integer "id",                                                                                       :default => 0,        :null => false
    t.integer "sucursal_id",             :limit => 1,                                                     :default => 0,        :null => false
    t.date    "ccom_fecha",                                                                                                     :null => false
    t.integer "tipocomprobante_id",      :limit => 1,                                                     :default => 0,        :null => false
    t.integer "ccom_puntosventa",                                                                         :default => 0,        :null => false
    t.integer "ccom_desdecompro",                                                                         :default => 0
    t.integer "ccom_hastacompro"
    t.integer "ccom_codigoaduana",       :limit => 1
    t.string  "ccom_codigodestinacion",  :limit => 4,                                                     :default => "IC04",   :null => false
    t.integer "ccom_nrodespacho"
    t.string  "ccom_digverdespacho",     :limit => 1,                                                     :default => "0",      :null => false
    t.integer "proveedor_id",                                                                             :default => 0,        :null => false
    t.integer "renplaegreso_id"
    t.integer "cabplaegreso_id"
    t.integer "pagocompra_id"
    t.integer "retencionganancia_id"
    t.decimal "ccom_retencioniva",                                         :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_percepcioniva",                                        :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_retencionganancia",                                    :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_retencionib",                                          :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_percepcionib",                                         :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_retencionmunicipal",                                   :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_nogravado",                                            :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_impuestointerno",                                      :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_exento",                                               :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_netogravado",                                          :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_iva",                                                  :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.decimal "ccom_total",                                                :precision => 12, :scale => 2, :default => 0.0,      :null => false
    t.string  "ccom_cai",                :limit => 14,                                                    :default => "0",      :null => false
    t.enum    "ccom_ctcc",               :limit => [:Contado, :"Cta/Cte"],                                :default => :Contado, :null => false
    t.integer "jurisdiccion_id",                                                                          :default => 0,        :null => false
    t.integer "conceptoegreso_id",                                                                                              :null => false
    t.integer "ccom_nroplaegreso",                                                                        :default => 0,        :null => false
    t.enum    "ccom_gastocompra",        :limit => [:GASTO, :COMPRA]
    t.string  "ccom_usuario",            :limit => 8,                                                     :default => "",       :null => false
    t.date    "ccom_ultmod",                                                                                                    :null => false
  end

  create_table "cabcompras_pagocompras", :id => false, :force => true do |t|
    t.integer "pagocompra_id", :default => 0, :null => false
    t.integer "cabcompra_id",  :default => 0, :null => false
    t.integer "sucursal_id",   :default => 0, :null => false
  end

  create_table "cabentradastock", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,  :default => 0,  :null => false
    t.integer "id_cabentradastock",                :default => 0,  :null => false
    t.integer "cent_sucursalsalida", :limit => 1,  :default => 0,  :null => false
    t.integer "id_tipocomprobante",  :limit => 1,  :default => 0,  :null => false
    t.integer "cent_puntoventa",                   :default => 0,  :null => false
    t.integer "cent_nrocomprobante",               :default => 0,  :null => false
    t.date    "cent_fecha",                                        :null => false
    t.integer "id_codigomovimiento", :limit => 1,  :default => 0,  :null => false
    t.integer "id_proveedor",                      :default => 0,  :null => false
    t.string  "cent_usuario",        :limit => 8,  :default => "", :null => false
    t.date    "cent_ultmod",                                       :null => false
    t.date    "cent_fechaborrado",                                 :null => false
    t.string  "cent_borradopor",     :limit => 10, :default => "", :null => false
  end

  create_table "cabfactura", :id => false, :force => true do |t|
    t.integer "id_sucursal",            :limit => 1,                                                   :default => 0,         :null => false
    t.integer "id_cabfactura",                                                                         :default => 0,         :null => false
    t.integer "id_cabremito",                                                                          :default => 0,         :null => false
    t.integer "id_tipocomprobante",     :limit => 1,                                                   :default => 0,         :null => false
    t.integer "cfac_puntosventa",                                                                      :default => 0,         :null => false
    t.integer "cfac_nrocomprobante",                                                                   :default => 0,         :null => false
    t.integer "cfac_hojas",             :limit => 1,                                                   :default => 0,         :null => false
    t.integer "id_cabcaja",                                                                            :default => 0,         :null => false
    t.integer "id_codigomovimiento",    :limit => 1,                                                   :default => 0,         :null => false
    t.integer "cfac_nrolistaprecio",                                                                   :default => 0,         :null => false
    t.integer "id_jurisdiccion",        :limit => 1,                                                   :default => 0,         :null => false
    t.integer "id_revendedor",                                                                         :default => 0,         :null => false
    t.date    "cfac_fecha",                                                                                                   :null => false
    t.date    "cfac_vencimiento",                                                                                             :null => false
    t.integer "id_cliente",                                                                            :default => 0,         :null => false
    t.integer "id_vendedor",            :limit => 1,                                                   :default => 0,         :null => false
    t.integer "id_condicionpago",       :limit => 1,                                                   :default => 0,         :null => false
    t.enum    "cfac_porcuentayorden",   :limit => [:D, :M, :F],                                        :default => :D,        :null => false
    t.enum    "cfac_motivonc",          :limit => [:A, :D, :O, :R, :C],                                                       :null => false
    t.integer "cfac_afectadotipo",      :limit => 1,                                                   :default => 0,         :null => false
    t.integer "cfac_afectadopunto",                                                                    :default => 0,         :null => false
    t.integer "cfac_afectadonro",                                                                      :default => 0,         :null => false
    t.decimal "cfac_exento",                                            :precision => 10, :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_netogravado",                                       :precision => 10, :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_alicuotainscripto",                                 :precision => 5,  :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_iva",                                               :precision => 10, :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_alicuotaperiva",                                    :precision => 5,  :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_percepcioniva",                                     :precision => 10, :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_alicuotaperibr",                                    :precision => 5,  :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_percepcionibr",                                     :precision => 10, :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_ajustebi",                                          :precision => 5,  :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_ajusteredondeo",                                    :precision => 5,  :scale => 2, :default => 0.0,       :null => false
    t.decimal "cfac_total",                                             :precision => 10, :scale => 2, :default => 0.0,       :null => false
    t.string  "cfac_viajantepublico",   :limit => 1,                                                   :default => "",        :null => false
    t.string  "cfac_ncanulacion",       :limit => 20,                                                  :default => "",        :null => false
    t.string  "cfac_vehiculo",          :limit => 30,                                                                         :null => false
    t.string  "cfac_patente",           :limit => 6,                                                                          :null => false
    t.string  "cfac_telefono",          :limit => 20,                                                                         :null => false
    t.integer "cfac_nropromocion",      :limit => 1,                                                                          :null => false
    t.string  "cfac_detallepromocion",  :limit => 40,                                                                         :null => false
    t.decimal "cfac_porcpromocion",                                     :precision => 6,  :scale => 2,                        :null => false
    t.decimal "cfac_descpromocion",                                     :precision => 12, :scale => 2,                        :null => false
    t.enum    "cfac_origenpromocion",   :limit => [:Pedida, :Ofrecida],                                :default => :Ofrecida, :null => false
    t.integer "id_cabliquidareve",                                                                     :default => 0,         :null => false
    t.enum    "cfac_compelectronico",   :limit => [:Si, :No],                                          :default => :No,       :null => false
    t.string  "cfac_usuario",           :limit => 8,                                                   :default => "",        :null => false
    t.date    "cfac_ultmod",                                                                                                  :null => false
  end

  add_index "cabfactura", ["cfac_fecha", "cfac_puntosventa", "cfac_nrocomprobante"], :name => "fechaiva"
  add_index "cabfactura", ["cfac_puntosventa", "id_tipocomprobante", "cfac_nrocomprobante"], :name => "caja"
  add_index "cabfactura", ["id_cliente", "cfac_fecha"], :name => "cliente"
  add_index "cabfactura", ["id_tipocomprobante", "cfac_puntosventa", "cfac_nrocomprobante"], :name => "comprobante"
  add_index "cabfactura", ["id_vendedor", "cfac_fecha"], :name => "vendedor"

  create_table "cabfacturas", :id => false, :force => true do |t|
    t.integer "id",                                                                            :default => 0,   :null => false
    t.integer "sucursal_id",            :limit => 1,                                           :default => 0,   :null => false
    t.integer "cabremito_id",                                                                  :default => 0,   :null => false
    t.integer "tipocomprobante_id",     :limit => 1,                                           :default => 0,   :null => false
    t.integer "cfac_puntosventa",                                                              :default => 0,   :null => false
    t.integer "cfac_nrocomprobante",                                                           :default => 0,   :null => false
    t.integer "cfac_hojas",             :limit => 1,                                           :default => 0,   :null => false
    t.integer "cabcaja_id",                                                                    :default => 0,   :null => false
    t.integer "codigomovimiento_id",    :limit => 1,                                           :default => 0,   :null => false
    t.integer "cfac_nrolistaprecio",                                                           :default => 0,   :null => false
    t.integer "jurisdiccion_id",        :limit => 1,                                           :default => 0,   :null => false
    t.integer "revendedor_id",                                                                 :default => 0,   :null => false
    t.date    "cfac_fecha",                                                                                     :null => false
    t.date    "cfac_vencimiento",                                                                               :null => false
    t.integer "cliente_id",                                                                    :default => 0,   :null => false
    t.integer "vendedor_id",            :limit => 1,                                           :default => 0,   :null => false
    t.integer "condicionpago_id",       :limit => 1,                                           :default => 0,   :null => false
    t.enum    "cfac_porcuentayorden",   :limit => [:D, :M, :F],                                :default => :D,  :null => false
    t.integer "cfac_afectadotipo",      :limit => 1,                                           :default => 0,   :null => false
    t.integer "cfac_afectadopunto",                                                            :default => 0,   :null => false
    t.integer "cfac_afectadonro",                                                              :default => 0,   :null => false
    t.decimal "cfac_exento",                                    :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_netogravado",                               :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_alicuotainscripto",                         :precision => 5,  :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_iva",                                       :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_alicuotaperiva",                            :precision => 5,  :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_percepcioniva",                             :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_alicuotaperibr",                            :precision => 5,  :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_percepcionibr",                             :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_ajustebi",                                  :precision => 5,  :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_ajusteredondeo",                            :precision => 5,  :scale => 2, :default => 0.0, :null => false
    t.decimal "cfac_total",                                     :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.string  "cfac_viajantepublico",   :limit => 1,                                           :default => "",  :null => false
    t.string  "cfac_ncanulacion",       :limit => 20,                                          :default => "",  :null => false
    t.string  "cfac_vehiculo",          :limit => 30,                                                           :null => false
    t.string  "cfac_patente",           :limit => 6,                                                            :null => false
    t.string  "cfac_telefono",          :limit => 20,                                                           :null => false
    t.integer "cfac_nropromocion",      :limit => 1,                                                            :null => false
    t.string  "cfac_detallepromocion",  :limit => 40,                                                           :null => false
    t.decimal "cfac_porcpromocion",                             :precision => 6,  :scale => 2,                  :null => false
    t.decimal "cfac_descpromocion",                             :precision => 12, :scale => 2,                  :null => false
    t.string  "cfac_usuario",           :limit => 8,                                           :default => "",  :null => false
    t.date    "cfac_ultmod",                                                                                    :null => false
  end

  create_table "cabliquidacion", :id => false, :force => true do |t|
    t.integer "id_sucursal",           :limit => 1,                                       :default => 0,     :null => false
    t.integer "id_cabliquidacion",                                                        :default => 0,     :null => false
    t.boolean "id_tipocomprobante",                                                       :default => false, :null => false
    t.integer "cliq_puntosventa",                                                         :default => 0,     :null => false
    t.integer "cliq_nrocomprobante",                                                      :default => 0,     :null => false
    t.integer "cliq_hojas",            :limit => 1,                                       :default => 0,     :null => false
    t.date    "cliq_fecha",                                                                                  :null => false
    t.integer "id_proveedor",                                                             :default => 0,     :null => false
    t.integer "id_condicionpago",      :limit => 1,                                       :default => 0,     :null => false
    t.decimal "cliq_netocomision",                         :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_ivacomision",                          :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_totalcomision",                        :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_netoventa",                            :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_ivaventa",                             :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_totalventa",                           :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_netobonif",                            :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_ivabonif",                             :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_totalbonif",                           :precision => 12, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_netoliquidacion",                      :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_ivaliquidacion",                       :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.decimal "cliq_totalliquidacion",                     :precision => 10, :scale => 2, :default => 0.0,   :null => false
    t.enum    "cliq_anulado",          :limit => [:S, :N],                                :default => :N,    :null => false
    t.string  "cliq_usuario",          :limit => 8,                                       :default => "",    :null => false
    t.date    "cliq_ultmod",                                                                                 :null => false
  end

  add_index "cabliquidacion", ["cliq_fecha"], :name => "porcabliqfecha"

  create_table "cabliquidareve", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                         :default => 0,   :null => false
    t.integer "id_cabliquidareve",                                                        :default => 0,   :null => false
    t.date    "clrev_fecha",                                                                               :null => false
    t.integer "id_revendedor",                                                            :default => 0,   :null => false
    t.decimal "clrev_totalventa",                          :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "clrev_totalcomision",                       :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.enum    "clrev_anulado",       :limit => [:No, :Si],                                :default => :No, :null => false
    t.enum    "clrev_cerrada",       :limit => [:No, :Si],                                :default => :No, :null => false
    t.integer "id_cabfactura",                                                            :default => 0,   :null => false
    t.string  "clrev_usuario",       :limit => 8,                                                          :null => false
    t.date    "clrev_ultmod",                                                                              :null => false
  end

  add_index "cabliquidareve", ["id_sucursal", "clrev_fecha"], :name => "por_fecha"

  create_table "cabpedidoproveedor", :id => false, :force => true do |t|
    t.integer "id_sucursal",           :limit => 1,                              :default => 0,        :null => false
    t.integer "id_cabpedidoproveedor",                                           :default => 0,        :null => false
    t.integer "id_proveedor",                                                    :default => 0,        :null => false
    t.date    "cped_fecha",                                                                            :null => false
    t.enum    "cped_estado",           :limit => [:Abierto, :Cerrado, :Enviado], :default => :Abierto, :null => false
    t.string  "cped_observaciones",    :limit => 50,                             :default => "",       :null => false
    t.string  "cped_usuario",          :limit => 10,                             :default => "",       :null => false
    t.date    "cped_ultmod",                                                                           :null => false
  end

  add_index "cabpedidoproveedor", ["id_sucursal", "id_cabpedidoproveedor"], :name => "id_cabpedido", :unique => true

  create_table "cabpedidowebs", :force => true do |t|
    t.integer "sucursal_id",        :limit => 1,                                          :default => 0
    t.integer "cliente_id",                                                               :default => 0,        :null => false
    t.date    "pweb_fecha",                                                                                     :null => false
    t.enum    "pweb_estado",        :limit => [:Abierto, :Cerrado, :Enviado, :Procesado], :default => :Abierto, :null => false
    t.string  "pweb_observaciones", :limit => 50
    t.string  "pweb_usuario",       :limit => 10,                                                               :null => false
    t.date    "pweb_ultmod",                                                                                    :null => false
  end

  create_table "cabplaegreso", :id => false, :force => true do |t|
    t.integer "id_sucursal",        :limit => 1,                                       :default => 0,   :null => false
    t.integer "id_cabplaegreso",                                                       :default => 0,   :null => false
    t.integer "cpeg_nroplanilla",                                                      :default => 0,   :null => false
    t.date    "cpeg_fecha"
    t.enum    "cpeg_acargode",      :limit => [:C, :S],                                :default => :C,  :null => false
    t.decimal "cpeg_importe",                           :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.integer "id_cabcaja",                                                            :default => 0
    t.enum    "cpeg_cerrada",       :limit => [:N, :S],                                :default => :N,  :null => false
    t.enum    "cpeg_control",       :limit => [:N, :S],                                :default => :N,  :null => false
    t.date    "cpeg_fecharegistro"
    t.enum    "cpeg_exportada",     :limit => [:N, :S],                                :default => :N,  :null => false
    t.string  "cpeg_usuario",       :limit => 8,                                       :default => "",  :null => false
    t.date    "cpeg_ultmod",                                                                            :null => false
  end

  create_table "cabplaegresos", :id => false, :force => true do |t|
    t.integer "id",                                                                    :default => 0,   :null => false
    t.integer "sucursal_id",        :limit => 1,                                       :default => 0,   :null => false
    t.integer "cpeg_nroplanilla",                                                      :default => 0,   :null => false
    t.date    "cpeg_fecha"
    t.enum    "cpeg_acargode",      :limit => [:C, :S],                                :default => :C,  :null => false
    t.decimal "cpeg_importe",                           :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.integer "cabcaja_id",                                                            :default => 0
    t.enum    "cpeg_cerrada",       :limit => [:N, :S],                                :default => :N,  :null => false
    t.enum    "cpeg_control",       :limit => [:N, :S],                                :default => :N,  :null => false
    t.date    "cpeg_fecharegistro"
    t.enum    "cpeg_exportada",     :limit => [:N, :S],                                :default => :N,  :null => false
    t.string  "cpeg_usuario",       :limit => 8,                                       :default => "",  :null => false
    t.date    "cpeg_ultmod",                                                                            :null => false
  end

  create_table "cabrecibo", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                :default => 0,   :null => false
    t.integer "id_cabrecibo",                                                    :default => 0,   :null => false
    t.integer "id_tipocomprobante",  :limit => 1,                                :default => 0,   :null => false
    t.integer "crec_puntosventa",                                                :default => 0,   :null => false
    t.integer "crec_nrocomprobante",                                             :default => 0,   :null => false
    t.date    "crec_fecha",                                                                       :null => false
    t.integer "id_cabcaja",                                                      :default => 0,   :null => false
    t.integer "id_cliente",                                                      :default => 0,   :null => false
    t.integer "id_vendedor",         :limit => 1,                                :default => 0,   :null => false
    t.integer "id_condicionpago",    :limit => 1,                                :default => 0,   :null => false
    t.decimal "crec_importe",                     :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "crec_acuenta",                     :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "crec_anulado",        :limit => 1,                                :default => "N", :null => false
    t.string  "crec_usuario",        :limit => 8,                                :default => "",  :null => false
    t.date    "crec_ultmod",                                                                      :null => false
  end

  add_index "cabrecibo", ["crec_fecha", "id_cliente"], :name => "crec_fecha_2"
  add_index "cabrecibo", ["crec_fecha"], :name => "crec_fecha"
  add_index "cabrecibo", ["id_sucursal"], :name => "id_sucursal"
  add_index "cabrecibo", ["id_tipocomprobante"], :name => "id_tipocomprobante"

  create_table "cabrecibos", :id => false, :force => true do |t|
    t.integer "id",                                                              :default => 0,   :null => false
    t.integer "sucursal_id",         :limit => 1,                                :default => 0,   :null => false
    t.integer "tipocomprobante_id",  :limit => 1,                                :default => 0,   :null => false
    t.integer "cabcaja_id",                                                      :default => 0,   :null => false
    t.integer "cliente_id",                                                      :default => 0,   :null => false
    t.integer "vendedor_id",         :limit => 1,                                :default => 0,   :null => false
    t.integer "condicionpago_id",    :limit => 1,                                :default => 0,   :null => false
    t.integer "crec_puntosventa",                                                :default => 0,   :null => false
    t.integer "crec_nrocomprobante",                                             :default => 0,   :null => false
    t.date    "crec_fecha",                                                                       :null => false
    t.decimal "crec_importe",                     :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "crec_acuenta",                     :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "crec_anulado",        :limit => 1,                                :default => "N", :null => false
    t.string  "crec_usuario",        :limit => 8,                                :default => "",  :null => false
    t.date    "crec_ultmod",                                                                      :null => false
  end

  create_table "cabreingresostock", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1,        :default => 0,  :null => false
    t.integer "id_cabreingresostock",                     :default => 0,  :null => false
    t.integer "id_tipocomprobante",   :limit => 1,        :default => 0,  :null => false
    t.date    "crei_fecha",                                               :null => false
    t.integer "id_cliente",                               :default => 0,  :null => false
    t.enum    "crei_anulado",         :limit => [:N, :S], :default => :N, :null => false
    t.string  "crei_usuario",         :limit => 8,        :default => "", :null => false
    t.date    "crei_ultmod",                                              :null => false
  end

  create_table "cabremito", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1,        :default => 0,   :null => false
    t.integer "id_cabremito",                             :default => 0,   :null => false
    t.integer "id_tipocomprobante",   :limit => 1,        :default => 0,   :null => false
    t.integer "crem_puntosventa",                         :default => 0,   :null => false
    t.integer "crem_nrocomprobante",                      :default => 0,   :null => false
    t.integer "crem_hojas",           :limit => 1,        :default => 0,   :null => false
    t.date    "crem_fecha",                                                :null => false
    t.integer "id_cliente",                               :default => 0,   :null => false
    t.integer "id_vendedor",          :limit => 1,        :default => 0,   :null => false
    t.integer "id_codigomovimiento",  :limit => 1,        :default => 0,   :null => false
    t.integer "crem_sucursaldestino", :limit => 1,        :default => 0,   :null => false
    t.string  "crem_observacion",     :limit => 100,      :default => "",  :null => false
    t.string  "crem_viajantepublico", :limit => 1,        :default => "P", :null => false
    t.string  "crem_anulado",         :limit => 1,        :default => "",  :null => false
    t.enum    "crem_porcuentayorden", :limit => [:S, :N], :default => :N,  :null => false
    t.string  "crem_usuario",         :limit => 8,        :default => "",  :null => false
    t.date    "crem_ultmod",                                               :null => false
  end

  add_index "cabremito", ["crem_fecha", "id_tipocomprobante", "crem_nrocomprobante"], :name => "fecha"
  add_index "cabremito", ["id_codigomovimiento"], :name => "codigomovi"
  add_index "cabremito", ["id_sucursal", "id_cliente", "crem_fecha"], :name => "cliente"
  add_index "cabremito", ["id_sucursal", "id_vendedor", "crem_fecha"], :name => "sucvenfec"
  add_index "cabremito", ["id_tipocomprobante", "crem_nrocomprobante"], :name => "nrocomprobante"

  create_table "cabremitos", :id => false, :force => true do |t|
    t.integer "id",                                       :default => 0,   :null => false
    t.integer "sucursal_id",          :limit => 1,        :default => 0,   :null => false
    t.integer "tipocomprobante_id",   :limit => 1,        :default => 0,   :null => false
    t.integer "crem_puntosventa",                         :default => 0,   :null => false
    t.integer "crem_nrocomprobante",                      :default => 0,   :null => false
    t.integer "crem_hojas",           :limit => 1,        :default => 0,   :null => false
    t.date    "crem_fecha",                                                :null => false
    t.integer "cliente_id",                               :default => 0,   :null => false
    t.integer "vendedor_id",          :limit => 1,        :default => 0,   :null => false
    t.integer "codigomovimiento_id",  :limit => 1,        :default => 0,   :null => false
    t.integer "crem_sucursaldestino", :limit => 1,        :default => 0,   :null => false
    t.string  "crem_observacion",     :limit => 100,      :default => "",  :null => false
    t.string  "crem_viajantepublico", :limit => 1,        :default => "P", :null => false
    t.string  "crem_anulado",         :limit => 1,        :default => "",  :null => false
    t.enum    "crem_porcuentayorden", :limit => [:S, :N], :default => :N,  :null => false
    t.string  "crem_usuario",         :limit => 8,        :default => "",  :null => false
    t.date    "crem_ultmod",                                               :null => false
  end

  create_table "cabsalidacartera", :id => false, :force => true do |t|
    t.integer "id_sucursal",            :limit => 1,                                                          :null => false
    t.integer "id_cabsalidacartera",                                                         :default => 0,   :null => false
    t.integer "id_destinocheter",                                                            :default => 0,   :null => false
    t.integer "id_proveedor",                                                                                 :null => false
    t.integer "id_cuentabancaria",      :limit => 1,                                                          :null => false
    t.integer "csca_nroboletadepo",                                                                           :null => false
    t.integer "csca_nrolote",                                                                :default => 0,   :null => false
    t.integer "csca_nropaquete",                                                                              :null => false
    t.date    "csca_fechageneracion",                                                                         :null => false
    t.time    "csca_horageneracion",                                                                          :null => false
    t.date    "csca_fechacierre",                                                                             :null => false
    t.time    "csca_horacierre",                                                                              :null => false
    t.date    "csca_fechaimpresion",                                                                          :null => false
    t.time    "csca_horaimpresion",                                                                           :null => false
    t.decimal "csca_importetotal",                            :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "csca_observacion",       :limit => 50,                                                         :null => false
    t.enum    "csca_cerrada",           :limit => [:No, :Si],                                :default => :No, :null => false
    t.enum    "csca_baja",              :limit => [:No, :Si],                                :default => :No, :null => false
    t.date    "csca_fechabaja",                                                                               :null => false
    t.integer "csca_idsucursalcaucion", :limit => 1,                                                          :null => false
    t.integer "csca_idlistadocaucion",                                                                        :null => false
    t.string  "csca_usuario",           :limit => 8,                                                          :null => false
    t.date    "csca_ultmod",                                                                                  :null => false
  end

  create_table "cancelacionremito", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1, :default => 0,  :null => false
    t.integer "id_cancelacionremito",              :default => 0,  :null => false
    t.integer "id_cabremito",                      :default => 0,  :null => false
    t.integer "id_renremito",                      :default => 0,  :null => false
    t.integer "id_cabfactura",                     :default => 0,  :null => false
    t.integer "id_renfactura",                     :default => 0,  :null => false
    t.integer "id_cabreingresostock",              :default => 0,  :null => false
    t.integer "id_renreingresostock",              :default => 0,  :null => false
    t.integer "canr_cantidad",                     :default => 0,  :null => false
    t.integer "id_articulo",          :limit => 8, :default => 0,  :null => false
    t.string  "canr_usuario",         :limit => 8, :default => "", :null => false
    t.date    "canr_ultmod",                                       :null => false
  end

  add_index "cancelacionremito", ["id_sucursal", "id_cabfactura"], :name => "porsuccabfac"
  add_index "cancelacionremito", ["id_sucursal", "id_cabremito"], :name => "porsuccabrem"

  create_table "catalogocai", :id => false, :force => true do |t|
    t.integer "id_catalogocai",                    :default => 0,  :null => false
    t.string  "ccai_numerocai",     :limit => 14,  :default => "", :null => false
    t.integer "id_tipocomprobante",                :default => 0,  :null => false
    t.date    "ccai_fechainicio",                                  :null => false
    t.date    "ccai_fechafinal",                                   :null => false
    t.string  "ccai_puntosventa",   :limit => 4,   :default => "", :null => false
    t.string  "ccai_autorizacion",  :limit => 15,  :default => "", :null => false
    t.string  "ccai_observacion",   :limit => 100, :default => "", :null => false
  end

  create_table "catalogonumero", :id => false, :force => true do |t|
    t.integer "id_tipocomprobante",              :default => 0,  :null => false
    t.string  "cnum_puntosventa",   :limit => 4, :default => "", :null => false
    t.string  "cnum_comprobante",   :limit => 8, :default => "", :null => false
  end

  create_table "categories", :id => false, :force => true do |t|
    t.string  "name",      :limit => 50,                :null => false
    t.integer "parent_id",               :default => 0, :null => false
  end

  create_table "cccliente", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                :default => 0,   :null => false
    t.integer "id_cccliente",                                                    :default => 0,   :null => false
    t.integer "id_cabfactura",                                                   :default => 0,   :null => false
    t.integer "id_cabrecibo",                                                    :default => 0,   :null => false
    t.integer "id_cliente",                                                      :default => 0,   :null => false
    t.date    "cccl_fecha",                                                                       :null => false
    t.integer "cccl_caja",                                                       :default => 0,   :null => false
    t.integer "id_tipocomprobante",                                              :default => 0,   :null => false
    t.integer "cccl_puntosventa",                                                :default => 0,   :null => false
    t.integer "cccl_nrocomprobante",                                             :default => 0,   :null => false
    t.integer "cccl_tipoafectado",                                               :default => 0,   :null => false
    t.integer "cccl_puntoafectado",                                              :default => 0,   :null => false
    t.integer "cccl_nroafectado",                                                :default => 0,   :null => false
    t.decimal "cccl_importedebe",                 :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "cccl_importehaber",                :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.integer "id_vendedor",         :limit => 1,                                :default => 0,   :null => false
    t.string  "cccl_reciboacuenta",  :limit => 1,                                :default => "",  :null => false
    t.string  "cccl_usuario",        :limit => 8,                                :default => "",  :null => false
    t.date    "cccl_ultmod",                                                                      :null => false
  end

  add_index "cccliente", ["id_sucursal", "id_cliente", "cccl_fecha"], :name => "porsuccliafectacion"
  add_index "cccliente", ["id_sucursal", "id_cliente", "cccl_fecha"], :name => "porsucclifecha"

  create_table "ccproveedor", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                :default => 0,   :null => false
    t.integer "id_ccproveedor",                                                  :default => 0,   :null => false
    t.integer "id_cabfactura",                                                   :default => 0,   :null => false
    t.integer "id_cabrecibo",                                                    :default => 0,   :null => false
    t.integer "id_proveedor",                                                    :default => 0,   :null => false
    t.date    "ccpr_fecha",                                                                       :null => false
    t.integer "id_tipocomprobante",                                              :default => 0,   :null => false
    t.integer "ccpr_puntosventa",                                                :default => 0,   :null => false
    t.integer "ccpr_nrocomprobante",                                             :default => 0,   :null => false
    t.integer "ccpr_tipoafectado",                                               :default => 0,   :null => false
    t.integer "ccpr_puntoafectado",                                              :default => 0,   :null => false
    t.integer "ccpr_nroafectado",                                                :default => 0,   :null => false
    t.decimal "ccpr_importedebe",                 :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "ccpr_importehaber",                :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "ccpr_usuario",        :limit => 8,                                                 :null => false
    t.date    "ccpr_ultmod",                                                                      :null => false
  end

  add_index "ccproveedor", ["id_sucursal", "id_proveedor", "ccpr_fecha"], :name => "porsucproafectacion"
  add_index "ccproveedor", ["id_sucursal", "id_proveedor", "ccpr_fecha"], :name => "porsucprofecha"

  create_table "chequetercero", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,        :default => 0,   :null => false
    t.integer "id_chequetercero",                        :default => 0,   :null => false
    t.integer "id_cabrecibo",                            :default => 0,   :null => false
    t.integer "id_cabfactura",                           :default => 0,   :null => false
    t.integer "id_cabcaja",                              :default => 0,   :null => false
    t.integer "id_cliente",                              :default => 0,   :null => false
    t.integer "id_banco",                                :default => 0,   :null => false
    t.date    "cter_ingreso",                                             :null => false
    t.integer "cter_sucursalbanco",                      :default => 0,   :null => false
    t.integer "cter_codigopostal",                       :default => 0,   :null => false
    t.integer "cter_nrocheque",                          :default => 0,   :null => false
    t.integer "cter_nrocuenta",      :limit => 8,        :default => 0,   :null => false
    t.string  "cter_cuitlibrador",   :limit => 11,       :default => "0", :null => false
    t.date    "cter_vencimiento",                                         :null => false
    t.date    "cter_emision",                                             :null => false
    t.float   "cter_importe",        :limit => 10,       :default => 0.0, :null => false
    t.integer "id_motivoingreso",    :limit => 1,        :default => 0,   :null => false
    t.string  "cter_observaciones",  :limit => 50,       :default => "0", :null => false
    t.integer "id_motivoegreso",     :limit => 1,        :default => 0,   :null => false
    t.date    "cter_egreso"
    t.string  "cter_observadestino", :limit => 50,       :default => "",  :null => false
    t.integer "id_listadocaucion",                       :default => 0,   :null => false
    t.enum    "cter_borradocaucion", :limit => [:S, :N], :default => :S,  :null => false
    t.string  "cter_usuario",        :limit => 8,        :default => "",  :null => false
    t.date    "cter_ultmod",                                              :null => false
  end

  add_index "chequetercero", ["cter_nrocheque"], :name => "pornumero"
  add_index "chequetercero", ["cter_vencimiento"], :name => "cter_vencimiento"
  add_index "chequetercero", ["id_cabcaja"], :name => "id_cabcaja"
  add_index "chequetercero", ["id_sucursal", "id_cliente", "cter_ingreso"], :name => "id_sucursal"

  create_table "chequeterceros", :id => false, :force => true do |t|
    t.integer "id",                                      :default => 0,   :null => false
    t.integer "sucursal_id",         :limit => 1,        :default => 0,   :null => false
    t.integer "cabrecibo_id",                            :default => 0,   :null => false
    t.integer "cabfactura_id",                           :default => 0,   :null => false
    t.integer "cabcaja_id",                              :default => 0,   :null => false
    t.integer "cliente_id",                              :default => 0,   :null => false
    t.integer "banco_id",                                :default => 0,   :null => false
    t.date    "cter_ingreso",                                             :null => false
    t.integer "cter_sucursalbanco",                      :default => 0,   :null => false
    t.integer "cter_codigopostal",                       :default => 0,   :null => false
    t.integer "cter_nrocheque",                          :default => 0,   :null => false
    t.integer "cter_nrocuenta",      :limit => 8,        :default => 0,   :null => false
    t.string  "cter_cuitlibrador",   :limit => 11,       :default => "0", :null => false
    t.date    "cter_vencimiento",                                         :null => false
    t.date    "cter_emision",                                             :null => false
    t.float   "cter_importe",        :limit => 10,       :default => 0.0, :null => false
    t.integer "motivoingreso_id",    :limit => 1,        :default => 0,   :null => false
    t.string  "cter_observaciones",  :limit => 50,       :default => "0", :null => false
    t.integer "motivoegreso_id",     :limit => 1,        :default => 0,   :null => false
    t.date    "cter_egreso"
    t.string  "cter_observadestino", :limit => 50,       :default => "",  :null => false
    t.integer "listadocaucion_id",                       :default => 0,   :null => false
    t.enum    "cter_borradocaucion", :limit => [:S, :N], :default => :S,  :null => false
    t.string  "cter_usuario",        :limit => 8,        :default => "",  :null => false
    t.date    "cter_ultmod",                                              :null => false
  end

  create_table "cliente", :id => false, :force => true do |t|
    t.integer "id_cliente",                                                      :default => 0,           :null => false
    t.integer "id_sucursal",          :limit => 1,                               :default => 0,           :null => false
    t.integer "clie_codigo",                                                     :default => 0,           :null => false
    t.string  "clie_razonsocial",     :limit => 50,                              :default => "",          :null => false
    t.string  "clie_contacto",        :limit => 50,                              :default => "",          :null => false
    t.string  "clie_telefono",        :limit => 100,                             :default => "",          :null => false
    t.string  "clie_email",           :limit => 100,                             :default => "",          :null => false
    t.string  "clie_url",             :limit => 30,                              :default => "",          :null => false
    t.integer "id_situacionafip",     :limit => 1,                               :default => 0,           :null => false
    t.integer "id_tipodocumento",     :limit => 1,                               :default => 0,           :null => false
    t.string  "clie_cuit",            :limit => 11,                              :default => "0",         :null => false
    t.string  "clie_domicilio",       :limit => 30,                              :default => "",          :null => false
    t.string  "clie_puerta",          :limit => 5,                               :default => "",          :null => false
    t.integer "id_localidad",                                                    :default => 0,           :null => false
    t.integer "id_vendedor",                                                     :default => 0,           :null => false
    t.date    "clie_ultimacompra",                                                                        :null => false
    t.float   "clie_saldo",           :limit => 10,                              :default => 0.0,         :null => false
    t.enum    "clie_estado",          :limit => [:Habilitado, :"No Habilitado"], :default => :Habilitado, :null => false
    t.integer "clie_ingbrutos",       :limit => 8,                               :default => 0,           :null => false
    t.float   "clie_porcib",          :limit => 5,                               :default => 0.0,         :null => false
    t.integer "clie_cuentamadre",                                                :default => 0,           :null => false
    t.string  "clie_observaciones",   :limit => 100,                             :default => "",          :null => false
    t.string  "clie_movimiento",      :limit => 1,                               :default => "",          :null => false
    t.date    "clie_baja",                                                                                :null => false
    t.float   "clie_saldofavor",      :limit => 10,                              :default => 0.0,         :null => false
    t.integer "clie_cpanterior",                                                 :default => 0,           :null => false
    t.string  "clie_locanterior",     :limit => 30,                              :default => "",          :null => false
    t.enum    "clie_factelectronica", :limit => [:Si, :No],                      :default => :No,         :null => false
    t.string  "clie_usuario",         :limit => 8,                               :default => "",          :null => false
    t.date    "clie_ultmod",                                                                              :null => false
  end

  add_index "cliente", ["clie_cuit"], :name => "clie_cuit"
  add_index "cliente", ["clie_razonsocial"], :name => "razonsocial"
  add_index "cliente", ["id_sucursal", "clie_cuit"], :name => "id_sucursal"

  create_table "clientes", :id => false, :force => true do |t|
    t.integer "id",                                                            :default => 0,           :null => false
    t.integer "sucursal_id",        :limit => 1,                               :default => 0,           :null => false
    t.integer "clie_codigo",                                                   :default => 0,           :null => false
    t.string  "clie_razonsocial",   :limit => 50,                              :default => "",          :null => false
    t.string  "clie_contacto",      :limit => 50,                              :default => "",          :null => false
    t.string  "clie_telefono",      :limit => 100,                             :default => "",          :null => false
    t.string  "clie_email",         :limit => 100,                             :default => "",          :null => false
    t.string  "clie_url",           :limit => 30,                              :default => "",          :null => false
    t.integer "situacionafip_id",   :limit => 1,                               :default => 0,           :null => false
    t.integer "tipodocumento_id",   :limit => 1,                               :default => 0,           :null => false
    t.string  "clie_cuit",          :limit => 11,                              :default => "0",         :null => false
    t.string  "clie_domicilio",     :limit => 30,                              :default => "",          :null => false
    t.string  "clie_puerta",        :limit => 5,                               :default => "",          :null => false
    t.integer "localidad_id",                                                  :default => 0,           :null => false
    t.integer "vendedor_id",                                                   :default => 0,           :null => false
    t.date    "clie_ultimacompra",                                                                      :null => false
    t.float   "clie_saldo",         :limit => 10,                              :default => 0.0,         :null => false
    t.enum    "clie_estado",        :limit => [:Habilitado, :"No Habilitado"], :default => :Habilitado, :null => false
    t.integer "clie_ingbrutos",     :limit => 8,                               :default => 0,           :null => false
    t.float   "clie_porcib",        :limit => 5,                               :default => 0.0,         :null => false
    t.integer "clie_cuentamadre",                                              :default => 0,           :null => false
    t.string  "clie_observaciones", :limit => 100,                             :default => "",          :null => false
    t.string  "clie_movimiento",    :limit => 1,                               :default => "",          :null => false
    t.date    "clie_baja",                                                                              :null => false
    t.float   "clie_saldofavor",    :limit => 10,                              :default => 0.0,         :null => false
    t.integer "clie_cpanterior",                                               :default => 0,           :null => false
    t.string  "clie_usuario",       :limit => 8,                               :default => "",          :null => false
    t.date    "clie_ultmod",                                                                            :null => false
  end

  create_table "codigomovimiento", :primary_key => "id_codmov", :force => true do |t|
    t.integer "cmov_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "cmov_nombre",  :limit => 25, :default => "", :null => false
    t.string  "cmov_usuario", :limit => 8,  :default => "", :null => false
    t.date    "cmov_ultmod",                                :null => false
  end

  create_table "codigomovimientos", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,  :default => 0,  :null => false
    t.integer "cmov_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "cmov_nombre",  :limit => 25, :default => "", :null => false
    t.string  "cmov_usuario", :limit => 8,  :default => "", :null => false
    t.date    "cmov_ultmod",                                :null => false
  end

  create_table "comisionliqven", :id => false, :force => true do |t|
    t.integer "id_sucursal",      :limit => 1,  :default => 0,   :null => false
    t.integer "id_cabfactura",                  :default => 0,   :null => false
    t.float   "coml_netogravado", :limit => 12, :default => 0.0, :null => false
    t.float   "coml_iva",         :limit => 12, :default => 0.0, :null => false
    t.float   "coml_total",       :limit => 12, :default => 0.0, :null => false
    t.string  "coml_usuario",     :limit => 8,  :default => "",  :null => false
    t.date    "coml_ultmod",                                     :null => false
  end

  create_table "comproche", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "id_regucheque",                                                                                                    :default => 0,             :null => false
    t.integer "regc_reguchequeviejo",                                                                                             :default => 0,             :null => false
    t.integer "id_chequetercero",                                                                                                 :default => 0,             :null => false
    t.date    "regc_fecha",                                                                                                                                  :null => false
    t.enum    "regc_abogado",         :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.enum    "regc_estadocobro",     :limit => [:"No Cobrado", :"Cobro Parcial", :"Cobro Total"],                                :default => :"No Cobrado", :null => false
    t.enum    "regc_denuncia",        :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "id_origenchereg",      :limit => 1,                                                                                :default => 0,             :null => false
    t.string  "regc_detalleorigen",   :limit => 15,                                                                               :default => "",            :null => false
    t.decimal "regc_importe",                                                                      :precision => 12, :scale => 2, :default => 0.0,           :null => false
    t.decimal "regc_gastos",                                                                       :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.decimal "regc_intereses",                                                                    :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.enum    "regc_anulado",         :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "id_motivochereg",      :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "id_vendedor",          :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "regc_codbanco",                                                                                                    :default => 0,             :null => false
    t.integer "regc_sucbanco",                                                                                                    :default => 0,             :null => false
    t.integer "regc_cpcheque",                                                                                                    :default => 0,             :null => false
    t.integer "regc_nrocheque",                                                                                                   :default => 0,             :null => false
    t.date    "regc_vtocheque",                                                                                                                              :null => false
    t.string  "regc_comprobante",     :limit => 10,                                                                               :default => "",            :null => false
    t.string  "regc_cliente",         :limit => 50,                                                                               :default => "",            :null => false
    t.string  "regc_usuario",         :limit => 8,                                                                                :default => "",            :null => false
    t.date    "regc_ultmod",                                                                                                                                 :null => false
  end

  create_table "conceptocaucion", :primary_key => "id_conceptocaucion", :force => true do |t|
    t.integer "ccau_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "ccau_detalle", :limit => 20, :default => "", :null => false
    t.string  "ccau_usuario", :limit => 8,  :default => "", :null => false
    t.date    "ccau_ultmod",                                :null => false
  end

  create_table "conceptocaucions", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,  :default => 0,  :null => false
    t.integer "ccau_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "ccau_detalle", :limit => 20, :default => "", :null => false
    t.string  "ccau_usuario", :limit => 8,  :default => "", :null => false
    t.date    "ccau_ultmod",                                :null => false
  end

  create_table "conceptoegreso", :primary_key => "id_conceptoegreso", :force => true do |t|
    t.integer "cegr_codigo",                                                                          :default => 0,  :null => false
    t.string  "cegr_detalle",      :limit => 50,                                                      :default => "", :null => false
    t.enum    "cegr_tipoconcepto", :limit => [:G, :C, :V, :P, :T, :L],                                :default => :G, :null => false
    t.integer "id_planimpositivo",                                                                    :default => 0,  :null => false
    t.integer "id_plandecuenta",                                                                      :default => 0,  :null => false
    t.enum    "cegr_retganancia",  :limit => [:S, :N],                                                :default => :N, :null => false
    t.decimal "cegr_baseretgan",                                       :precision => 12, :scale => 2
    t.string  "cegr_usuario",      :limit => 8,                                                       :default => "", :null => false
    t.date    "cegr_ultmod",                                                                                          :null => false
  end

  create_table "conceptoegresos", :id => false, :force => true do |t|
    t.integer "id",                                                                                   :default => 0,  :null => false
    t.integer "cegr_codigo",                                                                          :default => 0,  :null => false
    t.string  "cegr_detalle",      :limit => 50,                                                      :default => "", :null => false
    t.enum    "cegr_tipoconcepto", :limit => [:G, :C, :V, :P, :T, :L],                                :default => :G, :null => false
    t.decimal "cegr_baseretgan",                                       :precision => 12, :scale => 2
    t.integer "planimpositivo_id",                                                                    :default => 0,  :null => false
    t.integer "plandecuenta_id",                                                                      :default => 0,  :null => false
    t.enum    "cegr_retganancia",  :limit => [:S, :N],                                                :default => :N, :null => false
    t.string  "cegr_usuario",      :limit => 8,                                                       :default => "", :null => false
    t.date    "cegr_ultmod",                                                                                          :null => false
  end

  create_table "condicionpago", :primary_key => "id_condicionpago", :force => true do |t|
    t.integer "cpag_codigo",  :limit => 1,        :default => 0,  :null => false
    t.string  "cpag_nombre",  :limit => 40,       :default => "", :null => false
    t.enum    "cpag_contado", :limit => [:S, :N], :default => :S, :null => false
    t.integer "cpag_dias",                        :default => 0,  :null => false
    t.string  "cpag_usuario", :limit => 8,        :default => "", :null => false
    t.date    "cpag_ultmod",                                      :null => false
  end

  create_table "condicionpagos", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,        :default => 0,  :null => false
    t.integer "cpag_codigo",  :limit => 1,        :default => 0,  :null => false
    t.string  "cpag_nombre",  :limit => 40,       :default => "", :null => false
    t.enum    "cpag_contado", :limit => [:S, :N], :default => :S, :null => false
    t.integer "cpag_dias",                        :default => 0,  :null => false
    t.string  "cpag_usuario", :limit => 8,        :default => "", :null => false
    t.date    "cpag_ultmod",                                      :null => false
  end

  create_table "consignatarios", :force => true do |t|
    t.integer "csgn_codigo",                                                   :default => 0,           :null => false
    t.string  "csgn_nombre",        :limit => 35,                                                       :null => false
    t.string  "csgn_calle",         :limit => 30,                                                       :null => false
    t.string  "csgn_puerta",        :limit => 5,                                                        :null => false
    t.integer "localidad_id",                                                  :default => 0,           :null => false
    t.text    "csgn_telefono",      :limit => 16777215
    t.integer "situacionafip_id",   :limit => 1,                               :default => 0,           :null => false
    t.integer "tipodocumento_id",   :limit => 1,                               :default => 0,           :null => false
    t.string  "csgn_cuit",          :limit => 11,                              :default => "0",         :null => false
    t.enum    "csgn_estado",        :limit => [:Habilitado, :"No Habilitado"], :default => :Habilitado, :null => false
    t.string  "csgn_observaciones", :limit => 100
    t.date    "csgn_baja"
    t.string  "csgn_usuario",       :limit => 8,                                                        :null => false
    t.date    "csgn_ultmod",                                                                            :null => false
  end

  add_index "consignatarios", ["csgn_codigo"], :name => "prov_codigo", :unique => true
  add_index "consignatarios", ["csgn_cuit"], :name => "por_cuit"
  add_index "consignatarios", ["csgn_nombre"], :name => "prov_nombre"

  create_table "cuentabancaria", :primary_key => "id_cuentabancaria", :force => true do |t|
    t.integer "id_banco",                       :default => 0,  :null => false
    t.string  "cban_descripcion", :limit => 40, :default => "", :null => false
    t.integer "id_plandecuenta",                :default => 0,  :null => false
    t.string  "cban_usuario",     :limit => 15, :default => "", :null => false
    t.date    "cban_ultmod",                                    :null => false
  end

  create_table "cuentabancarias", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0,  :null => false
    t.integer "banco_id",                       :default => 0,  :null => false
    t.string  "cban_descripcion", :limit => 40, :default => "", :null => false
    t.integer "plandecuenta_id",                :default => 0,  :null => false
    t.string  "cban_usuario",     :limit => 15, :default => "", :null => false
    t.date    "cban_ultmod",                                    :null => false
  end

  create_table "cuentacaja", :primary_key => "id_cuentacaja", :force => true do |t|
    t.integer "id_sucursal",                                                                                                                                                                                                                                          :default => 0,                   :null => false
    t.integer "id_plandecuenta",                                                                                                                                                                                                                                      :default => 0,                   :null => false
    t.enum    "ccaj_tipoasiento", :limit => [:"Gastos Generales", :"Cheques a regularizar", :"Ventas Contado", :"Deudores por Venta", :"Ventas Cuenta Corriente", :"Vales a reponer", :"Recupero Gastos Cheque", :"Intereses Comerciales", :"Cupones a regularizar"], :default => :"Gastos Generales", :null => false
    t.enum    "ccaj_detalle",     :limit => [:Si, :No],                                                                                                                                                                                                               :default => :Si,                 :null => false
    t.string  "ccaj_usuario",     :limit => 12,                                                                                                                                                                                                                       :default => "",                  :null => false
    t.date    "ccaj_ultmod",                                                                                                                                                                                                                                                                           :null => false
  end

  create_table "cuentacajas", :id => false, :force => true do |t|
    t.integer "id",                                                                                                                                                                                                                                                   :default => 0,                   :null => false
    t.integer "sucursal_id",                                                                                                                                                                                                                                          :default => 0,                   :null => false
    t.integer "plandecuenta_id",                                                                                                                                                                                                                                      :default => 0,                   :null => false
    t.enum    "ccaj_tipoasiento", :limit => [:"Gastos Generales", :"Cheques a regularizar", :"Ventas Contado", :"Deudores por Venta", :"Ventas Cuenta Corriente", :"Vales a reponer", :"Recupero Gastos Cheque", :"Intereses Comerciales", :"Cupones a regularizar"], :default => :"Gastos Generales", :null => false
    t.enum    "ccaj_detalle",     :limit => [:Si, :No],                                                                                                                                                                                                               :default => :Si,                 :null => false
    t.string  "ccaj_usuario",     :limit => 12,                                                                                                                                                                                                                       :default => "",                  :null => false
    t.date    "ccaj_ultmod",                                                                                                                                                                                                                                                                           :null => false
  end

  create_table "cuentaiva", :primary_key => "id_cuentaiva", :force => true do |t|
    t.integer "civa_codigo",                :default => 0,  :null => false
    t.string  "civa_nombre",  :limit => 25, :default => "", :null => false
    t.string  "civa_usuario", :limit => 8,  :default => "", :null => false
    t.date    "civa_ultmod",                                :null => false
  end

  add_index "cuentaiva", ["civa_codigo"], :name => "porcodigoiva"

  create_table "cuitcheques", :force => true do |t|
    t.string   "ccheq_cuit"
    t.string   "ccheq_razonsocial"
    t.string   "ccheq_localidad"
    t.string   "ccheq_provincia"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cuitcheques", ["ccheq_cuit"], :name => "ccheq_cuit", :unique => true

  create_table "cupontarjeta", :id => false, :force => true do |t|
    t.integer "id_sucursal",        :limit => 1,        :default => 0,   :null => false
    t.integer "id_cupontarjeta",                        :default => 0,   :null => false
    t.integer "id_cabrecibo",                           :default => 0,   :null => false
    t.integer "id_cabfactura",                          :default => 0,   :null => false
    t.integer "id_cabcaja",                             :default => 0,   :null => false
    t.integer "id_tarjetacredito",  :limit => 1,        :default => 0,   :null => false
    t.enum    "ctar_debcred",       :limit => [:D, :C], :default => :D,  :null => false
    t.string  "ctar_nrotarjeta",    :limit => 16,       :default => "0", :null => false
    t.string  "ctar_nrocupon",      :limit => 10,       :default => "",  :null => false
    t.integer "ctar_nrolote",                           :default => 0,   :null => false
    t.date    "ctar_emision",                                            :null => false
    t.float   "ctar_importe",       :limit => 10,       :default => 0.0, :null => false
    t.integer "ctar_cuotas",        :limit => 1,        :default => 0,   :null => false
    t.string  "ctar_observaciones", :limit => 50,       :default => "",  :null => false
    t.string  "ctar_usuario",       :limit => 8,        :default => "",  :null => false
    t.date    "ctar_ultmod",                                             :null => false
  end

  add_index "cupontarjeta", ["id_sucursal", "id_cabfactura"], :name => "porsucursalfactura"
  add_index "cupontarjeta", ["id_sucursal", "id_cabrecibo"], :name => "id_sucursal"

  create_table "depositocaucion", :force => true do |t|
    t.integer "id_sucursal",            :limit => 1,  :default => 0,  :null => false
    t.integer "id_chequetercero",                     :default => 0,  :null => false
    t.date    "dcau_fechadeposito",                                   :null => false
    t.integer "id_conceptocaucion",     :limit => 1,  :default => 0,  :null => false
    t.string  "dcau_nroboletadeposito", :limit => 10, :default => "", :null => false
    t.string  "dcau_usuario",           :limit => 8
    t.date    "dcau_ultmod"
  end

  add_index "depositocaucion", ["id_sucursal", "id_chequetercero"], :name => "por_idchequetercero"

  create_table "depositocaucions", :id => false, :force => true do |t|
    t.integer "id",                                   :default => 0,  :null => false
    t.integer "sucursal_id",            :limit => 1,  :default => 0,  :null => false
    t.integer "chequetercero_id",                     :default => 0,  :null => false
    t.date    "dcau_fechadeposito",                                   :null => false
    t.integer "conceptocaucion_id",     :limit => 1,  :default => 0,  :null => false
    t.string  "dcau_nroboletadeposito", :limit => 10, :default => "", :null => false
    t.string  "dcau_usuario",           :limit => 8
    t.date    "dcau_ultmod"
  end

  create_table "descrevendedors", :force => true do |t|
    t.integer "marca_id",        :limit => 1,                                :default => 0
    t.integer "rubro_id",                                                    :default => 0,   :null => false
    t.decimal "drev_descuento1",               :precision => 6, :scale => 2, :default => 0.0
    t.decimal "drev_descuento2",               :precision => 6, :scale => 2, :default => 0.0
    t.decimal "drev_descuento3",               :precision => 6, :scale => 2, :default => 0.0
    t.string  "drev_usuario",    :limit => 10
    t.date    "drev_ultmod"
  end

  create_table "descuentolista", :primary_key => "id_descuentolista", :force => true do |t|
    t.integer "desc_nrolista",                       :default => 0,   :null => false
    t.integer "maestrolista_id"
    t.integer "desc_nrocolumna", :limit => 1,        :default => 0,   :null => false
    t.integer "id_articulo",                         :default => 0,   :null => false
    t.float   "desc_porcentaje", :limit => 7,        :default => 0.0, :null => false
    t.string  "desc_titulo",     :limit => 10,       :default => "",  :null => false
    t.enum    "desc_tipocond",   :limit => [:V, :E], :default => :V,  :null => false
    t.string  "desc_usuario",    :limit => 8,        :default => "",  :null => false
    t.date    "desc_ultmod",                                          :null => false
  end

  add_index "descuentolista", ["desc_nrolista"], :name => "desc_nrodelista"

  create_table "descuentolistas", :id => false, :force => true do |t|
    t.integer "id",                                  :default => 0,   :null => false
    t.integer "desc_nrolista",                       :default => 0,   :null => false
    t.integer "desc_nrocolumna", :limit => 1,        :default => 0,   :null => false
    t.integer "articulo_id",                         :default => 0,   :null => false
    t.float   "desc_porcentaje", :limit => 7,        :default => 0.0, :null => false
    t.string  "desc_titulo",     :limit => 10,       :default => "",  :null => false
    t.enum    "desc_tipocond",   :limit => [:V, :E], :default => :V,  :null => false
    t.string  "desc_usuario",    :limit => 8,        :default => "",  :null => false
    t.date    "desc_ultmod",                                          :null => false
  end

  create_table "descuentorenfac", :id => false, :force => true do |t|
    t.integer "id_sucursal",    :limit => 1, :default => 0,   :null => false
    t.integer "id_renfactura",               :default => 0,   :null => false
    t.integer "id_cabfactura",               :default => 0,   :null => false
    t.float   "drfa_descuento", :limit => 6, :default => 0.0, :null => false
    t.string  "drfa_usuario",   :limit => 8, :default => "",  :null => false
    t.date    "drfa_ultmod",                                  :null => false
  end

  add_index "descuentorenfac", ["id_sucursal", "id_renfactura"], :name => "porsucursalrenglon"

  create_table "destinocheter", :primary_key => "id_destinocheter", :force => true do |t|
    t.integer "dcht_codigo",            :limit => 1,                                      :default => 0,       :null => false
    t.string  "dcht_detalle",           :limit => 50,                                                          :null => false
    t.enum    "dcht_tipodestino",       :limit => [:P, :B, :R, :V, :C],                   :default => :V,      :null => false
    t.enum    "dcht_tiposalida",        :limit => [:"Por Lote", :"Por Paquete", :Varios], :default => :Varios, :null => false
    t.integer "id_proveedor",                                                                                  :null => false
    t.enum    "dcht_proyeccion",        :limit => [:No, :Si],                             :default => :No,     :null => false
    t.integer "dcht_idcuentadeudora",                                                                          :null => false
    t.integer "dcht_idcuentaacreedora",                                                                        :null => false
    t.string  "dcht_usuario",           :limit => 8,                                                           :null => false
    t.date    "dcht_ultmod",                                                                                   :null => false
  end

  add_index "destinocheter", ["dcht_codigo"], :name => "dcht_codigo"

  create_table "destinocheters", :id => false, :force => true do |t|
    t.integer "id",                     :limit => 1,                                      :default => 0,       :null => false
    t.integer "dcht_codigo",            :limit => 1,                                      :default => 0,       :null => false
    t.string  "dcht_detalle",           :limit => 50,                                                          :null => false
    t.enum    "dcht_tipodestino",       :limit => [:P, :B, :R, :V, :C],                   :default => :V,      :null => false
    t.enum    "dcht_tiposalida",        :limit => [:"Por Lote", :"Por Paquete", :Varios], :default => :Varios, :null => false
    t.integer "proveedor_id",                                                                                  :null => false
    t.enum    "dcht_proyeccion",        :limit => [:No, :Si],                             :default => :No,     :null => false
    t.integer "dcht_idcuentadeudora",                                                                          :null => false
    t.integer "dcht_idcuentaacreedora",                                                                        :null => false
    t.string  "dcht_usuario",           :limit => 8,                                                           :null => false
    t.date    "dcht_ultmod",                                                                                   :null => false
  end

  create_table "devueltocaucions", :force => true do |t|
    t.integer "chequetercero_id"
    t.integer "sucursal_id",              :limit => 1
    t.integer "devc_cabsalidacarteraant",                                                        :default => 0
    t.date    "devc_fecha"
    t.string  "devc_detalle"
    t.decimal "devc_importe",                                     :precision => 10, :scale => 2
    t.enum    "devc_tipo",                :limit => [:R, :A, :G]
    t.string  "devc_usuario"
    t.date    "devc_ultmod"
  end

  create_table "diccionario", :id => false, :force => true do |t|
    t.string  "nombre_tabla",      :limit => 20,  :default => "", :null => false
    t.string  "nombre_campo",      :limit => 20,  :default => "", :null => false
    t.string  "picture",           :limit => 15,  :default => "", :null => false
    t.integer "longitud",                         :default => 0,  :null => false
    t.string  "desc_corta",        :limit => 8,   :default => "", :null => false
    t.string  "desc_larga",        :limit => 25,  :default => "", :null => false
    t.string  "editable",          :limit => 1,   :default => "", :null => false
    t.string  "mostrable",         :limit => 1,   :default => "", :null => false
    t.string  "lookup",            :limit => 100, :default => "", :null => false
    t.string  "validacion",        :limit => 100, :default => "", :null => false
    t.string  "mensajevalidacion", :limit => 100, :default => "", :null => false
    t.string  "nombre_bd",         :limit => 10,  :default => "", :null => false
  end

  create_table "diccionariolookup", :id => false, :force => true do |t|
    t.string  "procedimiento",    :limit => 15,  :default => "", :null => false
    t.string  "variable",         :limit => 15,  :default => "", :null => false
    t.integer "linea_programa",                  :default => 0,  :null => false
    t.string  "campos_mostrados", :limit => 200, :default => "", :null => false
    t.string  "campo_devuelto",   :limit => 15,  :default => "", :null => false
    t.string  "sql_busquedas",    :limit => 200, :default => "", :null => false
  end

  create_table "ejercicios", :force => true do |t|
    t.date     "ejer_desde"
    t.date     "ejer_hasta"
    t.string   "ejer_descripcion"
    t.string   "ejer_cerrado"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresa", :id => false, :force => true do |t|
    t.integer "id_empresa"
    t.string  "empr_razonsocial",   :limit => 30,                                   :default => "\"Fleming y Martolio S.R.L\"", :null => false
    t.integer "id_sucursal"
    t.string  "empr_calle",         :limit => 20,                                   :default => "",                             :null => false
    t.string  "empr_puerta",        :limit => 5,                                    :default => "",                             :null => false
    t.integer "id_localidad",       :limit => 1,                                    :default => 0,                              :null => false
    t.string  "empr_telefono",      :limit => 8,                                    :default => "",                             :null => false
    t.integer "id_situacionafip",   :limit => 1,                                    :default => 0,                              :null => false
    t.string  "empr_cuit",          :limit => 11,                                   :default => "",                             :null => false
    t.float   "empr_alicuotainscr", :limit => 5,                                    :default => 0.0,                            :null => false
    t.string  "empr_ingbruto",      :limit => 13,                                   :default => "",                             :null => false
    t.enum    "empr_modoimpresion", :limit => [:"IMPRESORA FISCAL", :AUTOIMPRESOR], :default => :"IMPRESORA FISCAL",            :null => false
    t.string  "empr_email",         :limit => 50,                                   :default => "",                             :null => false
    t.integer "empr_listavigente",                                                  :default => 0,                              :null => false
    t.date    "empr_fechavigencia",                                                                                             :null => false
    t.string  "empr_usuario",       :limit => 8,                                    :default => "",                             :null => false
    t.date    "empr_ultmod",                                                                                                    :null => false
  end

  create_table "empresas", :id => false, :force => true do |t|
    t.integer "id"
    t.string  "empr_razonsocial",   :limit => 30,                                   :default => "\"Fleming y Martolio S.R.L\"", :null => false
    t.integer "sucursal_id"
    t.string  "empr_calle",         :limit => 20,                                   :default => "",                             :null => false
    t.string  "empr_puerta",        :limit => 5,                                    :default => "",                             :null => false
    t.integer "localidad_id",       :limit => 1,                                    :default => 0,                              :null => false
    t.string  "empr_telefono",      :limit => 8,                                    :default => "",                             :null => false
    t.integer "situacionafip_id",   :limit => 1,                                    :default => 0,                              :null => false
    t.string  "empr_cuit",          :limit => 11,                                   :default => "",                             :null => false
    t.float   "empr_alicuotainscr", :limit => 5,                                    :default => 0.0,                            :null => false
    t.string  "empr_ingbruto",      :limit => 13,                                   :default => "",                             :null => false
    t.enum    "empr_modoimpresion", :limit => [:"IMPRESORA FISCAL", :AUTOIMPRESOR], :default => :"IMPRESORA FISCAL",            :null => false
    t.string  "empr_email",         :limit => 50,                                   :default => "",                             :null => false
    t.integer "empr_listavigente",                                                  :default => 0,                              :null => false
    t.date    "empr_fechavigencia",                                                                                             :null => false
    t.string  "empr_usuario",       :limit => 8,                                    :default => "",                             :null => false
    t.date    "empr_ultmod",                                                                                                    :null => false
  end

  create_table "estadocheter", :primary_key => "id_estadocheter", :force => true do |t|
    t.integer "id_sucursal",         :limit => 1, :null => false
    t.integer "id_chequetercero",                 :null => false
    t.integer "id_cabsalidacartera",              :null => false
    t.integer "id_destinocheter",    :limit => 1, :null => false
    t.string  "echt_usuario",        :limit => 8, :null => false
    t.date    "echt_ultmod",                      :null => false
  end

  add_index "estadocheter", ["id_sucursal", "id_chequetercero"], :name => "por_idchequetercero", :unique => true

  create_table "estadocheters", :id => false, :force => true do |t|
    t.integer "id",                               :default => 0, :null => false
    t.integer "sucursal_id",         :limit => 1,                :null => false
    t.integer "chequetercero_id",                                :null => false
    t.integer "cabsalidacartera_id",                             :null => false
    t.integer "destinocheter_id",    :limit => 1,                :null => false
    t.string  "echt_usuario",        :limit => 8,                :null => false
    t.date    "echt_ultmod",                                     :null => false
  end

  create_table "formapago", :primary_key => "id_formapago", :force => true do |t|
    t.integer "fpag_codigo",            :limit => 1,          :default => 0,   :null => false
    t.integer "id_plandecuenta",                              :default => 0,   :null => false
    t.enum    "fpag_detalleenlacaja",   :limit => [:Si, :No], :default => :Si, :null => false
    t.string  "fpag_nombre",            :limit => 25,         :default => "",  :null => false
    t.enum    "fpag_permiterepocheque", :limit => [:No, :Si], :default => :No, :null => false
    t.string  "fpag_usuario",           :limit => 8,          :default => "",  :null => false
    t.date    "fpag_ultmod",                                                   :null => false
  end

  add_index "formapago", ["id_plandecuenta"], :name => "id_plandecuenta"

  create_table "formapagos", :id => false, :force => true do |t|
    t.integer "id",                     :limit => 1,          :default => 0,   :null => false
    t.integer "fpag_codigo",            :limit => 1,          :default => 0,   :null => false
    t.integer "plandecuenta_id",                              :default => 0,   :null => false
    t.enum    "fpag_detalleenlacaja",   :limit => [:Si, :No], :default => :Si, :null => false
    t.string  "fpag_nombre",            :limit => 25,         :default => "",  :null => false
    t.enum    "fpag_permiterepocheque", :limit => [:No, :Si], :default => :No, :null => false
    t.string  "fpag_usuario",           :limit => 8,          :default => "",  :null => false
    t.date    "fpag_ultmod",                                                   :null => false
  end

  create_table "formulario", :id => false, :force => true do |t|
    t.integer "id_tipoformulario",                                      :default => 0,         :null => false
    t.enum    "form_tipo",         :limit => [:HTML, :TXT, :PDF, :PS],  :default => :HTML,     :null => false
    t.enum    "form_parte",        :limit => [:CABECERA, :LINEA, :PIE], :default => :CABECERA, :null => false
    t.string  "form_linea",        :limit => 250,                       :default => "",        :null => false
  end

  create_table "grillalista", :id => false, :force => true do |t|
    t.integer "id_grillalista",                                :null => false
    t.integer "id_listaprecio",               :default => 0,   :null => false
    t.integer "glis_nrolista",                :default => 0
    t.integer "maestrolista_id",                               :null => false
    t.integer "glis_nrogrilla",  :limit => 1, :default => 0,   :null => false
    t.integer "glis_nrocolumna", :limit => 1, :default => 0,   :null => false
    t.float   "glis_porcentaje", :limit => 7, :default => 0.0, :null => false
    t.string  "glis_usuario",    :limit => 8
    t.date    "glis_ultmod"
  end

  add_index "grillalista", ["glis_nrogrilla", "glis_nrocolumna"], :name => "glis_nrogrilla"
  add_index "grillalista", ["id_grillalista"], :name => "id_grillalista"
  add_index "grillalista", ["id_listaprecio"], :name => "id_listaprecio"

  create_table "grillalistas", :id => false, :force => true do |t|
    t.integer "id",                           :default => 0,   :null => false
    t.integer "listaprecio_id",               :default => 0,   :null => false
    t.integer "glis_nrolista",                :default => 0
    t.integer "glis_nrogrilla",  :limit => 1, :default => 0,   :null => false
    t.integer "glis_nrocolumna", :limit => 1, :default => 0,   :null => false
    t.float   "glis_porcentaje", :limit => 7, :default => 0.0, :null => false
    t.string  "glis_usuario",    :limit => 8
    t.date    "glis_ultmod"
    t.integer "maestrolista_id",                               :null => false
  end

  create_table "jurisdiccion", :primary_key => "id_jurisdiccion", :force => true do |t|
    t.integer "juri_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "juri_nombre",  :limit => 25, :default => "", :null => false
    t.string  "juri_usuario", :limit => 8,  :default => "", :null => false
    t.date    "juri_ultmod",                                :null => false
  end

  create_table "jurisdiccions", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,  :default => 0,  :null => false
    t.integer "juri_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "juri_nombre",  :limit => 25, :default => "", :null => false
    t.string  "juri_usuario", :limit => 8,  :default => "", :null => false
    t.date    "juri_ultmod",                                :null => false
  end

  create_table "kardex", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,        :default => 0,  :null => false
    t.integer "id_kardex",           :limit => 8,        :default => 0,  :null => false
    t.integer "id_tipocomprobante",  :limit => 1,        :default => 0,  :null => false
    t.integer "kard_puntosventa",                        :default => 0,  :null => false
    t.integer "kard_nrocomprobante", :limit => 8,        :default => 0,  :null => false
    t.date    "kard_fecha",                                              :null => false
    t.string  "kard_clipro",         :limit => 30,       :default => "", :null => false
    t.enum    "kard_ingegr",         :limit => [:E, :I], :default => :E, :null => false
    t.integer "id_articulo",                             :default => 0,  :null => false
    t.integer "kard_cantidad",                           :default => 0,  :null => false
    t.string  "kard_usuario",        :limit => 8,        :default => "", :null => false
    t.date    "kard_ultmod",                                             :null => false
  end

  add_index "kardex", ["id_sucursal", "id_kardex"], :name => "principal"

  create_table "listadobancos", :force => true do |t|
    t.integer "listadocaucion_id",                                               :null => false
    t.integer "sucursal_id",                                                     :null => false
    t.decimal "lisb_importe",                     :precision => 10, :scale => 2
    t.date    "lisb_fecha"
    t.string  "lisb_usuario",      :limit => 100
    t.date    "lisb_ultmod"
  end

  create_table "listadocaucion", :id => false, :force => true do |t|
    t.integer "id_sucursal",            :limit => 1,                                       :default => 0,   :null => false
    t.integer "id_listadocaucion",                                                         :default => 0,   :null => false
    t.integer "lcau_nrocaja",                                                              :default => 0,   :null => false
    t.date    "lcau_fecha",                                                                                 :null => false
    t.integer "id_banco",                                                                  :default => 0,   :null => false
    t.integer "lcau_sucursalbanco",                                                        :default => 0,   :null => false
    t.string  "lcau_cuenta",            :limit => 11,                                      :default => "",  :null => false
    t.string  "lcau_denominacion",      :limit => 30,                                      :default => "",  :null => false
    t.decimal "lcau_importetotal",                          :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.enum    "lcau_cerrada",           :limit => [:N, :S],                                :default => :N,  :null => false
    t.integer "lcau_importebanco",      :limit => 10,       :precision => 10, :scale => 0
    t.date    "lcau_fechaimportebanco"
    t.string  "lcau_usuario",           :limit => 8,                                       :default => "",  :null => false
    t.date    "lcau_ultmod",                                                                                :null => false
  end

  create_table "listadocaucions", :id => false, :force => true do |t|
    t.integer "id",                                                                        :default => 0,   :null => false
    t.integer "sucursal_id",            :limit => 1,                                       :default => 0,   :null => false
    t.integer "lcau_nrocaja",                                                              :default => 0,   :null => false
    t.date    "lcau_fecha",                                                                                 :null => false
    t.integer "banco_id",                                                                  :default => 0,   :null => false
    t.integer "lcau_sucursalbanco",                                                        :default => 0,   :null => false
    t.string  "lcau_cuenta",            :limit => 11,                                      :default => "",  :null => false
    t.string  "lcau_denominacion",      :limit => 30,                                      :default => "",  :null => false
    t.decimal "lcau_importetotal",                          :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.enum    "lcau_cerrada",           :limit => [:N, :S],                                :default => :N,  :null => false
    t.integer "lcau_importebanco",      :limit => 10,       :precision => 10, :scale => 0
    t.date    "lcau_fechaimportebanco"
    t.string  "lcau_usuario",           :limit => 8,                                       :default => "",  :null => false
    t.date    "lcau_ultmod",                                                                                :null => false
  end

  create_table "listaprecio", :primary_key => "id_listaprecio", :force => true do |t|
    t.integer "lpre_nrolista",                                                             :default => 0
    t.enum    "lpre_codigolista",    :limit => [:C, :I, :T],                               :default => :C
    t.integer "id_articulo",                                                               :default => 0,   :null => false
    t.float   "lpre_preciolista",    :limit => 10,                                         :default => 0.0, :null => false
    t.float   "lpre_preciocosto",    :limit => 10,                                         :default => 0.0, :null => false
    t.float   "lpre_precioventa",    :limit => 10,                                         :default => 0.0, :null => false
    t.float   "lpre_remarque",       :limit => 5,                                          :default => 0.0
    t.decimal "lpre_remarque2",                              :precision => 6, :scale => 2, :default => 0.0
    t.decimal "lpre_remarque3",                              :precision => 6, :scale => 2, :default => 0.0
    t.integer "lpre_idlpreanterior"
    t.decimal "lpre_porcprovisorio",                         :precision => 6, :scale => 2, :default => 0.0
    t.string  "lpre_usuario",        :limit => 8
    t.date    "lpre_ultmod"
    t.integer "maestrolista_id"
  end

  add_index "listaprecio", ["id_articulo"], :name => "id_articulo"
  add_index "listaprecio", ["lpre_nrolista"], :name => "lpre_numer"

  create_table "listaprecios", :id => false, :force => true do |t|
    t.integer "id",                                                                        :default => 0,   :null => false
    t.integer "lpre_nrolista",                                                             :default => 0
    t.enum    "lpre_codigolista",    :limit => [:C, :I, :T],                               :default => :C
    t.integer "articulo_id",                                                               :default => 0,   :null => false
    t.float   "lpre_preciolista",    :limit => 10,                                         :default => 0.0, :null => false
    t.float   "lpre_preciocosto",    :limit => 10,                                         :default => 0.0, :null => false
    t.float   "lpre_precioventa",    :limit => 10,                                         :default => 0.0, :null => false
    t.float   "lpre_remarque",       :limit => 5,                                          :default => 0.0
    t.decimal "lpre_remarque2",                              :precision => 6, :scale => 2, :default => 0.0
    t.decimal "lpre_remarque3",                              :precision => 6, :scale => 2, :default => 0.0
    t.integer "lpre_idlpreanterior"
    t.decimal "lpre_porcprovisorio",                         :precision => 6, :scale => 2, :default => 0.0
    t.string  "lpre_usuario",        :limit => 8
    t.date    "lpre_ultmod"
    t.integer "maestrolista_id"
  end

  create_table "localidad", :primary_key => "id_localidad", :force => true do |t|
    t.integer "loca_codigopostal",               :default => 0,  :null => false
    t.integer "loca_estafeta",                   :default => 0,  :null => false
    t.string  "loca_nombre",       :limit => 30, :default => "", :null => false
    t.string  "loca_calle",        :limit => 30, :default => "", :null => false
    t.string  "loca_altura",       :limit => 15, :default => "", :null => false
    t.integer "id_provincia",                    :default => 0,  :null => false
    t.string  "loca_letraprovi",   :limit => 1,  :default => "", :null => false
    t.string  "loca_usuario",      :limit => 8,  :default => "", :null => false
    t.date    "loca_ultmod",                                     :null => false
  end

  add_index "localidad", ["loca_nombre"], :name => "loca_nombre"

  create_table "localidads", :id => false, :force => true do |t|
    t.integer "id",                              :default => 0,  :null => false
    t.integer "loca_codigopostal",               :default => 0,  :null => false
    t.integer "loca_estafeta",                   :default => 0,  :null => false
    t.string  "loca_nombre",       :limit => 30, :default => "", :null => false
    t.string  "loca_calle",        :limit => 30, :default => "", :null => false
    t.string  "loca_altura",       :limit => 15, :default => "", :null => false
    t.integer "provincia_id",                    :default => 0,  :null => false
    t.string  "loca_letraprovi",   :limit => 1,  :default => "", :null => false
    t.string  "loca_usuario",      :limit => 8,  :default => "", :null => false
    t.date    "loca_ultmod",                                     :null => false
  end

  create_table "logchequeterceros", :force => true do |t|
    t.integer "sucursal_id",                   :null => false
    t.string  "logc_cadenasql", :limit => 500
    t.date    "logc_fecha"
  end

  create_table "maestrolistas", :force => true do |t|
    t.integer "mlis_nrolista"
    t.integer "mlis_nrolistaorigen"
    t.date    "mlis_creacion"
    t.date    "mlis_vigencia"
    t.enum    "mlis_internapublica", :limit => [:Publica, :Interna]
    t.string  "mlis_usuario",        :limit => 8
    t.date    "mlis_ultmod"
    t.string  "mlis_nombre",         :limit => 50
    t.text    "mlis_observaciones",  :limit => 16777215
    t.string  "mlis_comentarioweb"
  end

  create_table "marca", :primary_key => "id_marca", :force => true do |t|
    t.integer "marc_codigo",      :limit => 1,  :default => 0,  :null => false
    t.string  "marc_descripcion", :limit => 30, :default => "", :null => false
    t.string  "marc_usuario",     :limit => 8,  :default => "", :null => false
    t.date    "marc_ultmod",                                    :null => false
  end

  add_index "marca", ["marc_codigo"], :name => "marc_codigo"

  create_table "marcas", :id => false, :force => true do |t|
    t.integer "id",               :limit => 1,  :default => 0,  :null => false
    t.integer "marc_codigo",      :limit => 1,  :default => 0,  :null => false
    t.string  "marc_descripcion", :limit => 30, :default => "", :null => false
    t.string  "marc_usuario",     :limit => 8,  :default => "", :null => false
    t.date    "marc_ultmod",                                    :null => false
  end

  create_table "motivochereg", :primary_key => "id_motivochereg", :force => true do |t|
    t.integer "motc_codigo",  :limit => 1,        :default => 0,  :null => false
    t.string  "motc_detalle", :limit => 20,       :default => "", :null => false
    t.enum    "motc_tipo",    :limit => [:H, :R], :default => :H, :null => false
    t.string  "motc_usuario", :limit => 8,        :default => "", :null => false
    t.date    "motc_ultmod",                                      :null => false
  end

  create_table "motivocheregs", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,        :default => 0,  :null => false
    t.integer "motc_codigo",  :limit => 1,        :default => 0,  :null => false
    t.string  "motc_detalle", :limit => 20,       :default => "", :null => false
    t.enum    "motc_tipo",    :limit => [:H, :R], :default => :H, :null => false
    t.string  "motc_usuario", :limit => 8,        :default => "", :null => false
    t.date    "motc_ultmod",                                      :null => false
  end

  create_table "motivocupreg", :primary_key => "id_motivocupreg", :force => true do |t|
    t.integer "mocu_codigo",     :limit => 1,    :default => 0,  :null => false
    t.string  "mocu_detalle",    :limit => 50,   :default => "", :null => false
    t.enum    "mocu_tipo",       :limit => [:R], :default => :R, :null => false
    t.integer "id_plandecuenta",                 :default => 0,  :null => false
    t.string  "mocu_usuario",    :limit => 8,    :default => "", :null => false
    t.date    "mocu_ultmod",                                     :null => false
  end

  create_table "motivocupregs", :id => false, :force => true do |t|
    t.integer "id",              :limit => 1,    :default => 0,  :null => false
    t.integer "mocu_codigo",     :limit => 1,    :default => 0,  :null => false
    t.string  "mocu_detalle",    :limit => 50,   :default => "", :null => false
    t.enum    "mocu_tipo",       :limit => [:R], :default => :R, :null => false
    t.integer "plandecuenta_id",                 :default => 0,  :null => false
    t.string  "mocu_usuario",    :limit => 8,    :default => "", :null => false
    t.date    "mocu_ultmod",                                     :null => false
  end

  create_table "motivoegreso", :primary_key => "id_motiegreso", :force => true do |t|
    t.integer "megr_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "megr_detalle", :limit => 15, :default => "", :null => false
    t.string  "megr_usuario", :limit => 8,  :default => "", :null => false
    t.date    "megr_ultmod",                                :null => false
  end

  create_table "motivoegresos", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,  :default => 0,  :null => false
    t.integer "megr_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "megr_detalle", :limit => 15, :default => "", :null => false
    t.string  "megr_usuario", :limit => 8,  :default => "", :null => false
    t.date    "megr_ultmod",                                :null => false
  end

  create_table "motivoingreso", :primary_key => "id_motivoingreso", :force => true do |t|
    t.integer "ming_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "ming_detalle", :limit => 15, :default => "", :null => false
    t.string  "ming_usuario", :limit => 8,  :default => "", :null => false
    t.date    "ming_ultmod",                                :null => false
  end

  create_table "motivoingresos", :id => false, :force => true do |t|
    t.integer "id",           :limit => 1,  :default => 0,  :null => false
    t.integer "ming_codigo",  :limit => 1,  :default => 0,  :null => false
    t.string  "ming_detalle", :limit => 15, :default => "", :null => false
    t.string  "ming_usuario", :limit => 8,  :default => "", :null => false
    t.date    "ming_ultmod",                                :null => false
  end

  create_table "netzke_preferences", :force => true do |t|
    t.string   "name"
    t.string   "pref_type"
    t.string   "value",       :limit => 50000
    t.integer  "user_id"
    t.integer  "role_id",                      :default => 0
    t.string   "widget_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "origenchereg", :primary_key => "id_origenchereg", :force => true do |t|
    t.integer "oric_codigo",     :limit => 1,        :default => 0,  :null => false
    t.string  "oric_detalle",    :limit => 30,       :default => "", :null => false
    t.integer "id_plandecuenta",                     :default => 0,  :null => false
    t.enum    "oric_debehaber",  :limit => [:D, :H], :default => :H, :null => false
    t.string  "oric_usuario",    :limit => 8,        :default => "", :null => false
    t.date    "oric_ultmod",                                         :null => false
  end

  create_table "origencheregs", :id => false, :force => true do |t|
    t.integer "id",              :limit => 1,        :default => 0,  :null => false
    t.integer "oric_codigo",     :limit => 1,        :default => 0,  :null => false
    t.string  "oric_detalle",    :limit => 30,       :default => "", :null => false
    t.integer "plandecuenta_id",                     :default => 0,  :null => false
    t.enum    "oric_debehaber",  :limit => [:D, :H], :default => :H, :null => false
    t.string  "oric_usuario",    :limit => 8,        :default => "", :null => false
    t.date    "oric_ultmod",                                         :null => false
  end

  create_table "pagocompra", :id => false, :force => true do |t|
    t.integer "id_pagocompra",                                                                  :null => false
    t.integer "id_sucursal",                                                   :default => 0,   :null => false
    t.integer "id_cabcaja"
    t.decimal "pcpr_efectivo",                  :precision => 12, :scale => 2, :default => 0.0
    t.decimal "pcpr_cheque",                    :precision => 12, :scale => 2, :default => 0.0
    t.decimal "pcpr_depotransf",                :precision => 12, :scale => 2, :default => 0.0
    t.decimal "pcpr_otro",                      :precision => 12, :scale => 2, :default => 0.0
    t.string  "pcpr_observacion", :limit => 75
    t.string  "pcpr_usuario",     :limit => 10
    t.date    "pcpr_ultmod"
  end

  create_table "pagocompras", :id => false, :force => true do |t|
    t.integer "id",                                                            :default => 0,   :null => false
    t.integer "sucursal_id",                                                   :default => 0,   :null => false
    t.integer "cabcaja_id"
    t.decimal "pcpr_cheque",                    :precision => 12, :scale => 2, :default => 0.0
    t.decimal "pcpr_efectivo",                  :precision => 12, :scale => 2, :default => 0.0
    t.decimal "pcpr_depotransf",                :precision => 12, :scale => 2, :default => 0.0
    t.decimal "pcpr_otro",                      :precision => 12, :scale => 2, :default => 0.0
    t.string  "pcpr_observacion", :limit => 75
    t.string  "pcpr_usuario",     :limit => 10
    t.date    "pcpr_ultmod"
  end

  create_table "pagocomprobante", :id => false, :force => true do |t|
    t.integer "id_sucursal",   :limit => 1,                                :default => 0,   :null => false
    t.integer "id_cabrecibo",                                              :default => 0,   :null => false
    t.integer "id_cabfactura",                                             :default => 0,   :null => false
    t.integer "id_cabcaja",                                                :default => 0,   :null => false
    t.integer "id_formapago",  :limit => 1,                                :default => 0,   :null => false
    t.integer "pcom_codigofp", :limit => 1,                                :default => 0,   :null => false
    t.decimal "pcom_importe",               :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "pcom_usuario",  :limit => 8,                                :default => "",  :null => false
    t.date    "pcom_ultmod",                                                                :null => false
  end

  add_index "pagocomprobante", ["id_formapago"], :name => "id_formapago"
  add_index "pagocomprobante", ["id_sucursal", "id_cabfactura"], :name => "porsucfac"
  add_index "pagocomprobante", ["id_sucursal", "id_cabrecibo"], :name => "porsucrec"

  create_table "plancuentaperiolo", :id => false, :force => true do |t|
    t.integer "cuenta",                     :null => false
    t.string  "descripcion", :limit => 100, :null => false
  end

  create_table "plandecuenta", :primary_key => "id_plandecuenta", :force => true do |t|
    t.integer "pcue_cuenta",                                                                                                       :null => false
    t.string  "pcue_descripcion",     :limit => 60,                                                               :default => "",  :null => false
    t.enum    "pcue_arqueo",          :limit => [:No, :Si],                                                       :default => :No, :null => false
    t.enum    "pcue_ajustemonetario", :limit => [:Si, :No],                                                       :default => :No, :null => false
    t.integer "id_sucursal",                                                                                      :default => 0,   :null => false
    t.enum    "pcue_pbi",             :limit => [:"STA.FE", :"E.RIOS"]
    t.enum    "pcue_tesorecontab",    :limit => [:T, :C],                                                         :default => :C,  :null => false
    t.enum    "pcue_permiteasiento",  :limit => [:Si, :No],                                                       :default => :Si, :null => false
    t.enum    "pcue_cc",              :limit => [:Si, :No],                                                       :default => :No, :null => false
    t.enum    "pcue_naturaleza",      :limit => [:Activo, :Pasivo, :PatrimonioNeto, :Resultados, :CuentadeOrden],                  :null => false
    t.enum    "pcue_nivel",           :limit => [:"1", :"2", :"3", :"4", :"5"]
    t.enum    "pcue_habilitada",      :limit => [:Si, :No],                                                       :default => :Si, :null => false
    t.integer "pcue_padre"
    t.string  "pcue_usuario",         :limit => 12,                                                               :default => "",  :null => false
    t.date    "pcue_ultmod",                                                                                                       :null => false
  end

  add_index "plandecuenta", ["pcue_cuenta"], :name => "pcue_cuenta", :unique => true

  create_table "plandecuentas", :id => false, :force => true do |t|
    t.integer "id",                                                                                               :default => 0,   :null => false
    t.integer "pcue_cuenta",                                                                                                       :null => false
    t.string  "pcue_descripcion",     :limit => 60,                                                               :default => "",  :null => false
    t.enum    "pcue_arqueo",          :limit => [:No, :Si],                                                       :default => :No, :null => false
    t.enum    "pcue_ajustemonetario", :limit => [:Si, :No],                                                       :default => :No, :null => false
    t.integer "sucursal_id",                                                                                      :default => 0,   :null => false
    t.enum    "pcue_pbi",             :limit => [:"STA.FE", :"E.RIOS"]
    t.enum    "pcue_tesorecontab",    :limit => [:T, :C],                                                         :default => :C,  :null => false
    t.enum    "pcue_permiteasiento",  :limit => [:Si, :No],                                                       :default => :Si, :null => false
    t.enum    "pcue_cc",              :limit => [:Si, :No],                                                       :default => :No, :null => false
    t.enum    "pcue_naturaleza",      :limit => [:Activo, :Pasivo, :PatrimonioNeto, :Resultados, :CuentadeOrden],                  :null => false
    t.enum    "pcue_nivel",           :limit => [:"1", :"2", :"3", :"4", :"5"]
    t.enum    "pcue_habilitada",      :limit => [:Si, :No],                                                       :default => :Si, :null => false
    t.integer "pcue_padre"
    t.string  "pcue_usuario",         :limit => 12,                                                               :default => "",  :null => false
    t.date    "pcue_ultmod",                                                                                                       :null => false
  end

  create_table "planimpositivo", :primary_key => "id_planimpositivo", :force => true do |t|
    t.integer "pimp_codigo",                                           :default => 0,  :null => false
    t.string  "pimp_descripcion", :limit => 60,                        :default => "", :null => false
    t.enum    "pimp_ambitodeuso", :limit => [:Compras, :Contabilidad],                 :null => false
    t.string  "pimp_usuario",     :limit => 8,                         :default => "", :null => false
    t.date    "pimp_ultmod",                                                           :null => false
  end

  create_table "planimpositivos", :id => false, :force => true do |t|
    t.integer "id",                                                    :default => 0,  :null => false
    t.integer "pimp_codigo",                                           :default => 0,  :null => false
    t.string  "pimp_descripcion", :limit => 60,                        :default => "", :null => false
    t.enum    "pimp_ambitodeuso", :limit => [:Compras, :Contabilidad],                 :null => false
    t.string  "pimp_usuario",     :limit => 8,                         :default => "", :null => false
    t.date    "pimp_ultmod",                                                           :null => false
  end

  create_table "promopirelli", :primary_key => "id_promopirelli", :force => true do |t|
    t.integer "ppir_codigo",              :limit => 1,                                :null => false
    t.string  "ppir_detalle",             :limit => 40,                               :null => false
    t.decimal "ppir_bonificacionnormal",                :precision => 6, :scale => 2, :null => false
    t.decimal "ppir_bonificacionfrances",               :precision => 6, :scale => 2, :null => false
    t.string  "ppir_usuario",             :limit => 8,                                :null => false
    t.date    "ppir_ultmod",                                                          :null => false
  end

  create_table "promopirellis", :id => false, :force => true do |t|
    t.integer "id",                       :limit => 1,                                :default => 0, :null => false
    t.integer "ppir_codigo",              :limit => 1,                                               :null => false
    t.string  "ppir_detalle",             :limit => 40,                                              :null => false
    t.decimal "ppir_bonificacionnormal",                :precision => 6, :scale => 2,                :null => false
    t.decimal "ppir_bonificacionfrances",               :precision => 6, :scale => 2,                :null => false
    t.string  "ppir_usuario",             :limit => 8,                                               :null => false
    t.date    "ppir_ultmod",                                                                         :null => false
  end

  create_table "proveedor", :id => false, :force => true do |t|
    t.integer "id_sucursal",                                                                               :null => false
    t.integer "id_proveedor",                                                                              :null => false
    t.integer "prov_codigo",                                                      :default => 0,           :null => false
    t.string  "prov_nombre",           :limit => 35,                              :default => "",          :null => false
    t.string  "prov_calle",            :limit => 30,                              :default => "",          :null => false
    t.string  "prov_puerta",           :limit => 5,                               :default => "",          :null => false
    t.integer "id_localidad",                                                     :default => 0,           :null => false
    t.text    "prov_telefono",         :limit => 16777215
    t.integer "id_situacionafip",      :limit => 1,                               :default => 0,           :null => false
    t.integer "id_tipodocumento",      :limit => 1,                               :default => 0,           :null => false
    t.string  "prov_cuit",             :limit => 11,                              :default => "0",         :null => false
    t.enum    "prov_estado",           :limit => [:Habilitado, :"No Habilitado"], :default => :Habilitado, :null => false
    t.integer "prov_ingbrutos",                                                   :default => 0,           :null => false
    t.integer "prov_regimenretencion",                                            :default => 0,           :null => false
    t.float   "prov_saldo",            :limit => 10
    t.string  "prov_observaciones",    :limit => 100
    t.enum    "prov_consignatario",    :limit => [:No, :Si],                      :default => :No,         :null => false
    t.date    "prov_baja"
    t.enum    "prov_exentoretgan",     :limit => [:No, :Si],                      :default => :No,         :null => false
    t.string  "prov_usuario",          :limit => 8,                               :default => "",          :null => false
    t.date    "prov_ultmod",                                                                               :null => false
  end

  add_index "proveedor", ["id_proveedor", "id_sucursal"], :name => "id_proveedor", :unique => true
  add_index "proveedor", ["prov_codigo"], :name => "prov_codigo", :unique => true
  add_index "proveedor", ["prov_nombre"], :name => "prov_nombre"

  create_table "proveedors", :id => false, :force => true do |t|
    t.integer "sucursal_id",                                                                               :null => false
    t.integer "id",                                                                                        :null => false
    t.integer "prov_codigo",                                                      :default => 0,           :null => false
    t.string  "prov_nombre",           :limit => 35,                              :default => "",          :null => false
    t.string  "prov_calle",            :limit => 30,                              :default => "",          :null => false
    t.string  "prov_puerta",           :limit => 5,                               :default => "",          :null => false
    t.integer "localidad_id",                                                     :default => 0,           :null => false
    t.text    "prov_telefono",         :limit => 16777215
    t.integer "situacionafip_id",      :limit => 1,                               :default => 0,           :null => false
    t.integer "tipodocumento_id",      :limit => 1,                               :default => 0,           :null => false
    t.string  "prov_cuit",             :limit => 11,                              :default => "0",         :null => false
    t.enum    "prov_estado",           :limit => [:Habilitado, :"No Habilitado"], :default => :Habilitado, :null => false
    t.integer "prov_ingbrutos",                                                   :default => 0,           :null => false
    t.integer "prov_regimenretencion",                                            :default => 0,           :null => false
    t.float   "prov_saldo",            :limit => 10
    t.string  "prov_observaciones",    :limit => 100
    t.enum    "prov_consignatario",    :limit => [:No, :Si],                      :default => :No,         :null => false
    t.date    "prov_baja"
    t.enum    "prov_exentoretgan",     :limit => [:No, :Si],                      :default => :No,         :null => false
    t.string  "prov_usuario",          :limit => 8,                               :default => "",          :null => false
    t.date    "prov_ultmod",                                                                               :null => false
  end

  create_table "provincia", :primary_key => "id_provincia", :force => true do |t|
    t.string  "pcia_nombre",      :limit => 20, :default => "", :null => false
    t.string  "pcia_abreviatura", :limit => 3,  :default => "", :null => false
    t.integer "pcia_codigoib",                  :default => 0,  :null => false
    t.string  "pcia_letra",       :limit => 1,  :default => "", :null => false
  end

  add_index "provincia", ["pcia_nombre", "pcia_codigoib"], :name => "prov_nombre"

  create_table "provincias", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0,  :null => false
    t.string  "pcia_nombre",      :limit => 20, :default => "", :null => false
    t.string  "pcia_abreviatura", :limit => 3,  :default => "", :null => false
    t.integer "pcia_codigoib",                  :default => 0,  :null => false
    t.string  "pcia_letra",       :limit => 1,  :default => "", :null => false
  end

  create_table "pruebas", :id => false, :force => true do |t|
    t.integer "id",          :null => false
    t.integer "sucursal_id", :null => false
    t.integer "algo"
  end

  create_table "puntosventas", :force => true do |t|
    t.integer "pven_punto",                                                                     :default => 0,  :null => false
    t.integer "sucursal_id",        :limit => 1,                                                :default => 0,  :null => false
    t.enum    "pven_modoimpresion", :limit => [:Autoimpresor, :Electronico, :CFiscal, :Manual],                 :null => false
    t.string  "pven_usuario",       :limit => 8,                                                :default => "", :null => false
    t.date    "pven_ultmod",                                                                                    :null => false
  end

  add_index "puntosventas", ["pven_punto"], :name => "puntosventa", :unique => true

  create_table "reclamos", :force => true do |t|
    t.string  "recl_estado",          :limit => 30,                                 :null => false
    t.string  "recl_nroprt",          :limit => 20
    t.date    "recl_fecha",                                                         :null => false
    t.string  "recl_nrointerno",      :limit => 16,                                 :null => false
    t.integer "sucursal_id",          :limit => 1,                                  :null => false
    t.integer "recl_codip",                                                         :null => false
    t.string  "recl_descripcionprod", :limit => 100
    t.string  "recl_dicpor",          :limit => 20
    t.string  "recl_dictamen",        :limit => 25
    t.integer "recl_motivo",                                                        :null => false
    t.string  "recl_notacredito",     :limit => 20
    t.date    "recl_fechanc"
    t.decimal "recl_bonificacion",                   :precision => 10, :scale => 2
    t.string  "recl_creditocliente",  :limit => 20
    t.integer "articulo_id"
    t.integer "cliente_id"
    t.string  "recl_nombrecliente",   :limit => 40
    t.string  "recl_documento",       :limit => 15
    t.string  "recl_usuario",         :limit => 10
    t.date    "recl_ultmod"
  end

  create_table "reclamostxt", :id => false, :force => true do |t|
    t.string  "recl_estado",          :limit => 30,                                 :null => false
    t.string  "recl_nroprt",          :limit => 20,                                 :null => false
    t.string  "recl_fecha",           :limit => 10,                                 :null => false
    t.string  "recl_nrointerno",      :limit => 16,                                 :null => false
    t.integer "recl_codip",                                                         :null => false
    t.string  "recl_descripcionprod", :limit => 100
    t.string  "recl_dicpor",          :limit => 20
    t.string  "recl_dictamen",        :limit => 25
    t.integer "recl_motivo",                                                        :null => false
    t.decimal "recl_bonificacion",                   :precision => 10, :scale => 2
    t.string  "recl_notacredito",     :limit => 20,                                 :null => false
    t.string  "recl_fechanc",         :limit => 10,                                 :null => false
  end

  create_table "regucheque", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "id_regucheque",                                                                                                    :default => 0,             :null => false
    t.integer "regc_reguchequeviejo",                                                                                             :default => 0,             :null => false
    t.integer "id_chequetercero",                                                                                                 :default => 0,             :null => false
    t.date    "regc_fecha",                                                                                                                                  :null => false
    t.enum    "regc_abogado",         :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.enum    "regc_estadocobro",     :limit => [:"No Cobrado", :"Cobro Parcial", :"Cobro Total"],                                :default => :"No Cobrado", :null => false
    t.enum    "regc_denuncia",        :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "id_origenchereg",      :limit => 1,                                                                                :default => 0,             :null => false
    t.string  "regc_detalleorigen",   :limit => 15,                                                                               :default => "",            :null => false
    t.decimal "regc_importe",                                                                      :precision => 12, :scale => 2, :default => 0.0,           :null => false
    t.decimal "regc_gastos",                                                                       :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.decimal "regc_intereses",                                                                    :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.enum    "regc_anulado",         :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "id_motivochereg",      :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "id_vendedor",          :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "regc_codbanco",                                                                                                    :default => 0,             :null => false
    t.integer "regc_sucbanco",                                                                                                    :default => 0,             :null => false
    t.integer "regc_cpcheque",                                                                                                    :default => 0,             :null => false
    t.integer "regc_nrocheque",                                                                                                   :default => 0,             :null => false
    t.date    "regc_vtocheque",                                                                                                                              :null => false
    t.string  "regc_comprobante",     :limit => 10,                                                                               :default => "",            :null => false
    t.string  "regc_cliente",         :limit => 50,                                                                               :default => "",            :null => false
    t.string  "regc_usuario",         :limit => 8,                                                                                :default => "",            :null => false
    t.date    "regc_ultmod",                                                                                                                                 :null => false
  end

  create_table "regucheques", :id => false, :force => true do |t|
    t.integer "id",                                                                                                               :default => 0,             :null => false
    t.integer "sucursal_id",          :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "regc_reguchequeviejo",                                                                                             :default => 0,             :null => false
    t.integer "chequetercero_id",                                                                                                 :default => 0,             :null => false
    t.date    "regc_fecha",                                                                                                                                  :null => false
    t.enum    "regc_abogado",         :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.enum    "regc_estadocobro",     :limit => [:"No Cobrado", :"Cobro Parcial", :"Cobro Total"],                                :default => :"No Cobrado", :null => false
    t.enum    "regc_denuncia",        :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "origenchereg_id",      :limit => 1,                                                                                :default => 0,             :null => false
    t.string  "regc_detalleorigen",   :limit => 15,                                                                               :default => "",            :null => false
    t.decimal "regc_importe",                                                                      :precision => 12, :scale => 2, :default => 0.0,           :null => false
    t.decimal "regc_gastos",                                                                       :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.decimal "regc_intereses",                                                                    :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.enum    "regc_anulado",         :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "motivochereg_id",      :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "vendedor_id",          :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "regc_codbanco",                                                                                                    :default => 0,             :null => false
    t.integer "regc_sucbanco",                                                                                                    :default => 0,             :null => false
    t.integer "regc_cpcheque",                                                                                                    :default => 0,             :null => false
    t.integer "regc_nrocheque",                                                                                                   :default => 0,             :null => false
    t.date    "regc_vtocheque",                                                                                                                              :null => false
    t.string  "regc_comprobante",     :limit => 10,                                                                               :default => "",            :null => false
    t.string  "regc_cliente",         :limit => 50,                                                                               :default => "",            :null => false
    t.string  "regc_usuario",         :limit => 8,                                                                                :default => "",            :null => false
    t.date    "regc_ultmod",                                                                                                                                 :null => false
  end

  create_table "regucupon", :id => false, :force => true do |t|
    t.integer "id_sucursal",      :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "id_regucupon",                                                                                                 :default => 0,             :null => false
    t.integer "id_cupontarjeta",                                                                                              :default => 0,             :null => false
    t.date    "rcup_fecha",                                                                                                                              :null => false
    t.enum    "rcup_estadocobro", :limit => [:"No Cobrado", :"Cobro Parcial", :"Cobro Total"],                                :default => :"No Cobrado", :null => false
    t.decimal "rcup_importe",                                                                  :precision => 12, :scale => 2, :default => 0.0,           :null => false
    t.decimal "rcup_gastos",                                                                   :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.decimal "rcup_intereses",                                                                :precision => 10, :scale => 2, :default => 0.0,           :null => false
    t.enum    "rcup_anulado",     :limit => [:No, :Si],                                                                       :default => :No,           :null => false
    t.integer "id_motivocupreg",  :limit => 1,                                                                                :default => 0,             :null => false
    t.integer "id_vendedor",      :limit => 1,                                                                                :default => 0,             :null => false
    t.string  "rcup_comprobante", :limit => 10,                                                                               :default => "",            :null => false
    t.string  "rcup_cliente",     :limit => 50,                                                                               :default => "",            :null => false
    t.string  "rcup_usuario",     :limit => 8,                                                                                :default => "",            :null => false
    t.date    "rcup_ultmod",                                                                                                                             :null => false
  end

  create_table "relacionegreplan", :primary_key => "id_relacionegreplan", :force => true do |t|
    t.integer "id_conceptoegreso",              :default => 0,  :null => false
    t.integer "id_sucursal",       :limit => 1, :default => 0,  :null => false
    t.integer "id_planimpositivo",              :default => 0,  :null => false
    t.string  "rela_usuario",      :limit => 8, :default => "", :null => false
    t.date    "rela_ultmod",                                    :null => false
  end

  create_table "relacionegreplanes", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0,  :null => false
    t.integer "conceptoegreso_id",              :default => 0,  :null => false
    t.integer "sucursal_id",       :limit => 1, :default => 0,  :null => false
    t.integer "planimpositivo_id",              :default => 0,  :null => false
    t.string  "rela_usuario",      :limit => 8, :default => "", :null => false
    t.date    "rela_ultmod",                                    :null => false
  end

  create_table "renajustestock", :id => false, :force => true do |t|
    t.integer "id_sucursal",       :limit => 1,        :default => 0,  :null => false
    t.integer "id_renajustestock", :limit => 8,        :default => 0,  :null => false
    t.integer "id_cabajustestock", :limit => 8,        :default => 0,  :null => false
    t.integer "raju_item",         :limit => 1,        :default => 0,  :null => false
    t.date    "raju_fecha",                                            :null => false
    t.integer "id_articulo",                           :default => 0,  :null => false
    t.integer "id_marca",                              :default => 0,  :null => false
    t.integer "id_rubro",                              :default => 0,  :null => false
    t.enum    "raju_ingegr",       :limit => [:E, :I], :default => :E, :null => false
    t.integer "raju_cantidad",                         :default => 0,  :null => false
    t.string  "raju_usuario",      :limit => 8,        :default => "", :null => false
    t.date    "raju_ultmod",                                           :null => false
  end

  create_table "renasiento", :primary_key => "id_renasiento", :force => true do |t|
    t.integer "id_cabasiento",                                  :default => 0,   :null => false
    t.integer "id_plandecuenta",                                :default => 0,   :null => false
    t.decimal "rasi_importe",    :precision => 12, :scale => 2, :default => 0.0, :null => false
  end

  create_table "renasientomodelos", :primary_key => "id_renasientomodelo", :force => true do |t|
    t.integer "id_cabasientomodelo",                                                   :default => 0,        :null => false
    t.integer "id_plandecuenta",                                                       :default => 0,        :null => false
    t.enum    "rasi_debeohaber",     :limit => [:Debe, :Haber],                        :default => :Debe,    :null => false
    t.enum    "rasi_tipo",           :limit => [:Contado, :"Cuenta Corriente", :Pago], :default => :Contado, :null => false
    t.string  "rasi_descripcion",    :limit => 40,                                     :default => "",       :null => false
  end

  create_table "renasientos", :id => false, :force => true do |t|
    t.integer "id",                                             :default => 0,   :null => false
    t.integer "cabasiento_id",                                  :default => 0,   :null => false
    t.integer "plandecuenta_id",                                :default => 0,   :null => false
    t.decimal "rasi_importe",    :precision => 12, :scale => 2, :default => 0.0, :null => false
  end

  create_table "rencargachequeters", :id => false, :force => true do |t|
    t.integer "id",                                :default => 0, :null => false
    t.integer "cabcargachequeter_id", :limit => 8, :default => 0, :null => false
    t.integer "sucursal_id",          :limit => 1,                :null => false
    t.integer "chequetercero_id",                  :default => 0, :null => false
  end

  create_table "rencomcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,  :default => 0,   :null => false
    t.integer "id_cabcaja",                        :default => 0,   :null => false
    t.integer "rcca_vendedor",                     :default => 0,   :null => false
    t.integer "id_tipocomprobante",  :limit => 1,  :default => 0,   :null => false
    t.integer "rcca_puntosventa",                  :default => 0,   :null => false
    t.integer "rcca_nrocomprobante",               :default => 0,   :null => false
    t.float   "rcca_importe",        :limit => 12, :default => 0.0, :null => false
    t.string  "rcca_contado",        :limit => 1,  :default => "",  :null => false
    t.string  "rcca_usuario",        :limit => 8,  :default => "",  :null => false
    t.date    "rcca_ultmod",                                        :null => false
  end

  create_table "rencompra", :id => false, :force => true do |t|
    t.integer "id_sucursal",       :limit => 1,                                :default => 0,   :null => false
    t.integer "id_rencompra",                                                  :default => 0,   :null => false
    t.integer "id_cabcompra",                                                  :default => 0,   :null => false
    t.decimal "rcom_netorenglon",               :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rcom_ivarenglon",                :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rcom_totalrenglon",              :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.integer "id_alicuotaiva",    :limit => 1,                                :default => 0,   :null => false
    t.string  "rcom_usuario",      :limit => 8,                                :default => "",  :null => false
    t.date    "rcom_ultmod",                                                                    :null => false
  end

  add_index "rencompra", ["id_sucursal", "id_cabcompra"], :name => "por_cabcompra"

  create_table "rencompras", :id => false, :force => true do |t|
    t.integer "id",                                                            :default => 0,   :null => false
    t.integer "sucursal_id",       :limit => 1,                                :default => 0,   :null => false
    t.integer "cabcompra_id",                                                  :default => 0,   :null => false
    t.integer "alicuotaiva_id",    :limit => 1,                                :default => 0,   :null => false
    t.decimal "rcom_netorenglon",               :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rcom_ivarenglon",                :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rcom_totalrenglon",              :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rcom_usuario",      :limit => 8,                                :default => "",  :null => false
    t.date    "rcom_ultmod",                                                                    :null => false
  end

  create_table "rendepcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",           :limit => 1,        :default => 0,   :null => false
    t.integer "id_rendepcaja",                             :default => 0,   :null => false
    t.integer "id_cabcaja",                                :default => 0,   :null => false
    t.date    "deca_fechadeposito",                                         :null => false
    t.string  "deca_bancoordenante",   :limit => 25,       :default => "",  :null => false
    t.integer "id_cuentabancaria",                         :default => 0,   :null => false
    t.string  "deca_bancodepositario", :limit => 25,       :default => "",  :null => false
    t.enum    "deca_efectivocheque",   :limit => [:E, :C], :default => :E,  :null => false
    t.float   "deca_importe",          :limit => 12,       :default => 0.0, :null => false
    t.string  "deca_usuario",          :limit => 8,        :default => "",  :null => false
    t.date    "deca_ultmod",                                                :null => false
  end

  create_table "rendoccaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",   :limit => 1,  :default => 0,   :null => false
    t.integer "id_rendoccaja",               :default => 0,   :null => false
    t.integer "id_cabcaja",                  :default => 0,   :null => false
    t.string  "doca_detalle",  :limit => 50, :default => "",  :null => false
    t.float   "doca_importe",  :limit => 10, :default => 0.0, :null => false
    t.string  "doca_usuario",  :limit => 8,  :default => "",  :null => false
    t.date    "doca_ultmod",                                  :null => false
  end

  create_table "renentradastock", :id => false, :force => true do |t|
    t.integer "id_sucursal",        :limit => 1,  :default => 0,  :null => false
    t.integer "id_renentradastock",               :default => 0,  :null => false
    t.integer "id_cabentradastock",               :default => 0,  :null => false
    t.integer "rent_item",          :limit => 1,  :default => 0,  :null => false
    t.date    "rent_fecha",                                       :null => false
    t.integer "id_articulo",                      :default => 0,  :null => false
    t.integer "id_marca",                         :default => 0,  :null => false
    t.integer "id_rubro",                         :default => 0,  :null => false
    t.integer "rent_cantidad",                    :default => 0,  :null => false
    t.string  "rent_usuario",       :limit => 8,  :default => "", :null => false
    t.date    "rent_fechaborrado",                                :null => false
    t.string  "rent_borradopor",    :limit => 10, :default => "", :null => false
  end

  add_index "renentradastock", ["id_sucursal", "id_cabentradastock"], :name => "id_sucursal"

  create_table "renfactura", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1,                                 :default => 0,   :null => false
    t.integer "id_renfactura",                                                     :default => 0,   :null => false
    t.integer "id_cabfactura",                                                     :default => 0,   :null => false
    t.integer "rfac_item",            :limit => 1,                                 :default => 0,   :null => false
    t.date    "rfac_fecha",                                                                         :null => false
    t.integer "id_articulo",                                                       :default => 0,   :null => false
    t.integer "id_alicuotaiva",       :limit => 1,                                 :default => 0,   :null => false
    t.integer "rfac_cantidad",                                                     :default => 0,   :null => false
    t.float   "rfac_preciocosto",     :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_preciounitario2", :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_netogravado4",    :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_netogravado2",    :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_iva2",            :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_totalrenglon2",   :limit => 11,                                :default => 0.0, :null => false
    t.integer "id_cabremito",                                                      :default => 0,   :null => false
    t.integer "id_renremito",                                                      :default => 0,   :null => false
    t.decimal "rfac_descpromocion",                 :precision => 12, :scale => 2,                  :null => false
    t.string  "rfac_usuario",         :limit => 8,                                 :default => "",  :null => false
    t.date    "rfac_ultmod",                                                                        :null => false
  end

  add_index "renfactura", ["id_sucursal", "id_cabremito", "id_renremito"], :name => "por_remito"

  create_table "renfacturas", :id => false, :force => true do |t|
    t.integer "id",                                                                :default => 0,   :null => false
    t.integer "sucursal_id",          :limit => 1,                                 :default => 0,   :null => false
    t.integer "cabfactura_id",                                                     :default => 0,   :null => false
    t.integer "rfac_item",            :limit => 1,                                 :default => 0,   :null => false
    t.date    "rfac_fecha",                                                                         :null => false
    t.integer "articulo_id",                                                       :default => 0,   :null => false
    t.integer "alicuotaiva_id",       :limit => 1,                                 :default => 0,   :null => false
    t.integer "rfac_cantidad",                                                     :default => 0,   :null => false
    t.float   "rfac_preciocosto",     :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_preciounitario2", :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_netogravado4",    :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_netogravado2",    :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_iva2",            :limit => 11,                                :default => 0.0, :null => false
    t.float   "rfac_totalrenglon2",   :limit => 11,                                :default => 0.0, :null => false
    t.integer "cabremito_id",                                                      :default => 0,   :null => false
    t.integer "renremito_id",                                                      :default => 0,   :null => false
    t.decimal "rfac_descpromocion",                 :precision => 12, :scale => 2,                  :null => false
    t.string  "rfac_usuario",         :limit => 8,                                 :default => "",  :null => false
    t.date    "rfac_ultmod",                                                                        :null => false
  end

  create_table "rengascaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",      :limit => 1,  :default => 0,   :null => false
    t.integer "id_rengascaja",                  :default => 0,   :null => false
    t.integer "id_cabcaja",                     :default => 0,   :null => false
    t.integer "gaca_nroplanilla",               :default => 0,   :null => false
    t.float   "gaca_importe",     :limit => 12, :default => 0.0, :null => false
    t.string  "gaca_usuario",     :limit => 8,  :default => "",  :null => false
    t.date    "gaca_ultmod",                                     :null => false
  end

  create_table "renliquidacion", :id => false, :force => true do |t|
    t.integer "id_sucursal",             :limit => 1,                                 :default => 0,   :null => false
    t.integer "id_renliquidacion",                                                    :default => 0,   :null => false
    t.integer "id_cabliquidacion",                                                    :default => 0,   :null => false
    t.string  "rliq_sucursal",           :limit => 3,                                 :default => "",  :null => false
    t.integer "rliq_item",               :limit => 1,                                 :default => 0,   :null => false
    t.integer "rliq_cantidad",                                                        :default => 0,   :null => false
    t.integer "id_articulo",                                                          :default => 0,   :null => false
    t.string  "rliq_detalle",            :limit => 50,                                :default => "",  :null => false
    t.integer "rliq_idtipocomprobante",  :limit => 1,                                 :default => 0,   :null => false
    t.integer "rliq_puntosventa",                                                     :default => 0,   :null => false
    t.integer "rliq_nrocomprobante",                                                  :default => 0,   :null => false
    t.integer "rliq_idtipcomremito",     :limit => 1,                                 :default => 0,   :null => false
    t.integer "rliq_ptovtaremito",                                                    :default => 0,   :null => false
    t.string  "rliq_nroremito",          :limit => 20,                                :default => "",  :null => false
    t.decimal "rliq_alicuotaiva",                      :precision => 6,  :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_costounitariofinal",               :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_costototalfinal",                  :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_ventaunitariofinal",               :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_netototal",                        :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_ivatotal",                         :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_ventatotalfinal",                  :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_netocomision",                     :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_ivacomision",                      :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.decimal "rliq_comisionfinal",                    :precision => 10, :scale => 2, :default => 0.0, :null => false
    t.string  "rliq_usuario",            :limit => 8,                                 :default => "",  :null => false
    t.date    "rliq_ultmod",                                                                           :null => false
  end

  create_table "renliquidareve", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                :null => false
    t.integer "id_renliquidareve",                                               :null => false
    t.integer "id_cabliquidareve",                                               :null => false
    t.integer "id_cabfactura",                                                   :null => false
    t.integer "id_renfactura",                                                   :null => false
    t.decimal "rlrev_totalcosto",                 :precision => 10, :scale => 2, :null => false
    t.decimal "rlrev_totalventa",                 :precision => 10, :scale => 2, :null => false
    t.decimal "rlrev_totalcomision",              :precision => 10, :scale => 2, :null => false
  end

  add_index "renliquidareve", ["id_sucursal", "id_cabfactura"], :name => "por_datosfactura"
  add_index "renliquidareve", ["id_sucursal", "id_cabliquidareve"], :name => "por_cabliquidareve"

  create_table "renncndvarios", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,  :default => 0,   :null => false
    t.integer "id_renncndvarios",                  :default => 0,   :null => false
    t.integer "id_cabfactura",                     :default => 0,   :null => false
    t.integer "rcd_item",            :limit => 1,  :default => 0,   :null => false
    t.date    "rcd_fecha",                                          :null => false
    t.string  "rcd_detalle",         :limit => 50, :default => "",  :null => false
    t.integer "id_alicuotaiva",      :limit => 1,  :default => 0,   :null => false
    t.integer "rcd_cantidad",                      :default => 0,   :null => false
    t.float   "rcd_preciocosto",     :limit => 11, :default => 0.0, :null => false
    t.float   "rcd_preciounitario2", :limit => 11, :default => 0.0, :null => false
    t.float   "rcd_netogravado4",    :limit => 11, :default => 0.0, :null => false
    t.float   "rcd_netogravado2",    :limit => 11, :default => 0.0, :null => false
    t.float   "rcd_iva2",            :limit => 11, :default => 0.0, :null => false
    t.float   "rcd_totalrenglon2",   :limit => 11, :default => 0.0, :null => false
    t.string  "rcd_usuario",         :limit => 8,  :default => "",  :null => false
    t.date    "rcd_ultmod",                                         :null => false
  end

  create_table "renpedidoproveedor", :id => false, :force => true do |t|
    t.integer "id_sucursal",           :limit => 1,  :default => 0,  :null => false
    t.integer "id_cabpedidoproveedor",               :default => 0,  :null => false
    t.integer "id_articulo",                         :default => 0,  :null => false
    t.integer "rped_cantidad",                       :default => 0,  :null => false
    t.integer "rped_recibida",                       :default => 0,  :null => false
    t.integer "rped_stockactual",                    :default => 0,  :null => false
    t.string  "rped_usuario",          :limit => 10, :default => "", :null => false
    t.date    "rped_ultmod",                                         :null => false
  end

  add_index "renpedidoproveedor", ["id_sucursal", "id_cabpedidoproveedor", "id_articulo"], :name => "id_renpedido", :unique => true

  create_table "renpedidowebs", :force => true do |t|
    t.integer "cabpedidoweb_id",                       :default => 0,   :null => false
    t.integer "articulo_id",                           :default => 0,   :null => false
    t.integer "rweb_cantidad",                         :default => 0,   :null => false
    t.enum    "rweb_procesado",  :limit => [:No, :Si], :default => :No, :null => false
    t.string  "rweb_usuario",    :limit => 10
    t.date    "rweb_ultmod"
  end

  create_table "renplaegreso", :id => false, :force => true do |t|
    t.integer "id_sucursal",       :limit => 1,                                 :default => 0,   :null => false
    t.integer "id_renplaegreso",                                                :default => 0,   :null => false
    t.integer "id_cabplaegreso",                                                :default => 0,   :null => false
    t.integer "id_conceptoegreso",                                              :default => 0,   :null => false
    t.string  "rpeg_observa",      :limit => 40
    t.decimal "rpeg_importe",                    :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rpeg_usuario",      :limit => 8,                                 :default => "",  :null => false
    t.date    "rpeg_ultmod",                                                                     :null => false
  end

  create_table "renplaegresos", :id => false, :force => true do |t|
    t.integer "id",                                                             :default => 0,   :null => false
    t.integer "sucursal_id",       :limit => 1,                                 :default => 0,   :null => false
    t.integer "cabplaegreso_id",                                                :default => 0,   :null => false
    t.integer "conceptoegreso_id",                                              :default => 0,   :null => false
    t.string  "rpeg_observa",      :limit => 40
    t.decimal "rpeg_importe",                    :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rpeg_usuario",      :limit => 8,                                 :default => "",  :null => false
    t.date    "rpeg_ultmod",                                                                     :null => false
  end

  create_table "renrcucaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                :default => 0,   :null => false
    t.integer "id_renrcucaja",                                                   :default => 0,   :null => false
    t.integer "id_cabcaja",                                                      :default => 0,   :null => false
    t.integer "rrcu_nrocomprobante",                                             :default => 0,   :null => false
    t.decimal "rrcu_importe",                     :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rrcu_usuario",        :limit => 8,                                :default => "",  :null => false
    t.date    "rrcu_ultmod",                                                                      :null => false
  end

  create_table "renreccaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,  :default => 0,   :null => false
    t.integer "id_cabcaja",                        :default => 0,   :null => false
    t.integer "reca_vendedor",                     :default => 0,   :null => false
    t.integer "id_tipocomprobante",  :limit => 1,  :default => 0,   :null => false
    t.integer "reca_puntosventa",                  :default => 0,   :null => false
    t.integer "reca_nrocomprobante",               :default => 0,   :null => false
    t.string  "reca_razsoccliente",  :limit => 50, :default => "",  :null => false
    t.float   "reca_importe",        :limit => 12, :default => 0.0, :null => false
    t.string  "reca_usuario",        :limit => 8,  :default => "",  :null => false
    t.date    "reca_ultmod",                                        :null => false
  end

  create_table "renrecibo", :id => false, :force => true do |t|
    t.integer "id_sucursal",        :limit => 1,                                :default => 0,   :null => false
    t.integer "id_renrecibo",                                                   :default => 0,   :null => false
    t.integer "id_cabrecibo",                                                   :default => 0,   :null => false
    t.integer "rrec_item",          :limit => 1,                                :default => 0,   :null => false
    t.integer "id_cuentacorriente",                                             :default => 0,   :null => false
    t.decimal "rrec_importe",                    :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rrec_usuario",       :limit => 8,                                :default => "",  :null => false
    t.date    "rrec_ultmod",                                                                     :null => false
  end

  create_table "renreingresostock", :id => false, :force => true do |t|
    t.integer "id_sucursal",          :limit => 1, :default => 0,  :null => false
    t.integer "id_renreingresostock",              :default => 0,  :null => false
    t.integer "id_cabreingresostock",              :default => 0,  :null => false
    t.integer "rrei_item",            :limit => 1, :default => 0,  :null => false
    t.date    "rrei_fecha",                                        :null => false
    t.integer "id_articulo",                       :default => 0,  :null => false
    t.integer "id_marca",                          :default => 0,  :null => false
    t.integer "id_rubro",                          :default => 0,  :null => false
    t.integer "rrei_cantidad",                     :default => 0,  :null => false
    t.integer "id_cabremito",                      :default => 0,  :null => false
    t.integer "id_renremito",                      :default => 0,  :null => false
    t.string  "rrei_usuario",         :limit => 8, :default => "", :null => false
    t.date    "rrei_ultmod",                                       :null => false
  end

  create_table "renremito", :id => false, :force => true do |t|
    t.integer "id_sucursal",        :limit => 1, :default => 0,  :null => false
    t.integer "id_renremito",                    :default => 0,  :null => false
    t.integer "id_cabremito",                    :default => 0,  :null => false
    t.integer "rrem_item",          :limit => 1, :default => 0,  :null => false
    t.date    "rrem_fecha",                                      :null => false
    t.integer "id_articulo",                     :default => 0,  :null => false
    t.integer "rrem_cantidad",                   :default => 0,  :null => false
    t.integer "rrem_cantifactu",                 :default => 0,  :null => false
    t.string  "rrem_controlastock", :limit => 1, :default => "", :null => false
    t.string  "rrem_usuario",       :limit => 8, :default => "", :null => false
    t.date    "rrem_ultmod",                                     :null => false
  end

  add_index "renremito", ["id_sucursal", "id_cabremito"], :name => "por_cabremito"

  create_table "renremitos", :id => false, :force => true do |t|
    t.integer "id",                              :default => 0,  :null => false
    t.integer "sucursal_id",        :limit => 1, :default => 0,  :null => false
    t.integer "cabremito_id",                    :default => 0,  :null => false
    t.integer "rrem_item",          :limit => 1, :default => 0,  :null => false
    t.date    "rrem_fecha",                                      :null => false
    t.integer "articulo_id",                     :default => 0,  :null => false
    t.integer "rrem_cantidad",                   :default => 0,  :null => false
    t.integer "rrem_cantifactu",                 :default => 0,  :null => false
    t.string  "rrem_controlastock", :limit => 1, :default => "", :null => false
    t.string  "rrem_usuario",       :limit => 8, :default => "", :null => false
    t.date    "rrem_ultmod",                                     :null => false
  end

  create_table "renrendcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",            :limit => 1,                                :default => 0,   :null => false
    t.integer "id_cabcaja",                                                         :default => 0,   :null => false
    t.integer "id_formapago",           :limit => 1,                                :default => 0,   :null => false
    t.decimal "rrca_importeoriginal",                :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rrca_importemodi",                    :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rrca_importerepocheque",              :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.decimal "rrca_importerepocupon",               :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rrca_usuario",           :limit => 8,                                :default => "",  :null => false
    t.date    "rrca_ultmod",                                                                         :null => false
  end

  add_index "renrendcaja", ["id_sucursal", "id_cabcaja"], :name => "rendicion"

  create_table "renrepcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1,                                :default => 0,   :null => false
    t.integer "id_renrepcaja",                                                   :default => 0,   :null => false
    t.integer "id_cabcaja",                                                      :default => 0,   :null => false
    t.integer "rche_nrocomprobante",                                             :default => 0,   :null => false
    t.decimal "rche_importe",                     :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "rche_usuario",        :limit => 8,                                :default => "",  :null => false
    t.date    "rche_ultmod",                                                                      :null => false
  end

  create_table "rensalidacartera", :id => false, :force => true do |t|
    t.integer "id_sucursal",         :limit => 1, :null => false
    t.integer "id_rensalidacartera",              :null => false
    t.integer "id_cabsalidacartera",              :null => false
    t.integer "rsca_idsucursal",     :limit => 1, :null => false
    t.integer "id_chequetercero",                 :null => false
  end

  create_table "renvalcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",   :limit => 1,  :default => 0,   :null => false
    t.integer "id_renvalcaja",               :default => 0,   :null => false
    t.integer "id_cabcaja",                  :default => 0,   :null => false
    t.string  "vcaj_detalle",  :limit => 50, :default => "",  :null => false
    t.float   "vcaj_importe",  :limit => 10, :default => 0.0, :null => false
    t.string  "vcaj_usuario",  :limit => 8,  :default => "",  :null => false
    t.date    "vcaj_ultmod",                                  :null => false
  end

  create_table "renvarcaja", :id => false, :force => true do |t|
    t.integer "id_sucursal",   :limit => 1,  :default => 0,   :null => false
    t.integer "id_renvarcaja",               :default => 0,   :null => false
    t.integer "id_cabcaja",                  :default => 0,   :null => false
    t.string  "vaca_detalle",  :limit => 50, :default => "",  :null => false
    t.float   "vaca_importe",  :limit => 10, :default => 0.0, :null => false
    t.string  "vaca_usuario",  :limit => 8,  :default => "",  :null => false
    t.date    "vaca_ultmod",                                  :null => false
  end

  create_table "repocheque", :id => false, :force => true do |t|
    t.integer "id_sucursal",   :limit => 1,                                :default => 0,   :null => false
    t.integer "id_repocheque",                                             :default => 0,   :null => false
    t.integer "id_regucheque",                                             :default => 0,   :null => false
    t.date    "repc_fecha",                                                                 :null => false
    t.decimal "repc_importe",               :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "repc_usuario",  :limit => 8,                                :default => "",  :null => false
    t.date    "repc_ultmod",                                                                :null => false
  end

  create_table "repocupon", :id => false, :force => true do |t|
    t.integer "id_sucursal",  :limit => 1,                                :default => 0,   :null => false
    t.integer "id_repocupon",                                             :default => 0,   :null => false
    t.integer "id_regucupon",                                             :default => 0,   :null => false
    t.date    "recu_fecha",                                                                :null => false
    t.decimal "recu_importe",              :precision => 12, :scale => 2, :default => 0.0, :null => false
    t.string  "recu_usuario", :limit => 8,                                :default => "",  :null => false
    t.date    "recu_ultmod",                                                               :null => false
  end

  create_table "retencionganancias", :id => false, :force => true do |t|
    t.integer "id",                                                            :default => 0,   :null => false
    t.integer "sucursal_id",                                                   :default => 0,   :null => false
    t.decimal "rtga_importe",                   :precision => 12, :scale => 2, :default => 0.0
    t.string  "rtga_nroorden",    :limit => 50
    t.integer "rtga_plaegresoid"
    t.string  "rtga_usuario",     :limit => 10
    t.date    "rtga_ultmod"
  end

  create_table "retenpercep", :id => false, :force => true do |t|
    t.integer "id_retenpercep",                                    :default => 0,    :null => false
    t.enum    "retp_impuesto",       :limit => [:GAN, :IVA, :IBR], :default => :GAN, :null => false
    t.string  "retp_cuitagente",     :limit => 11,                 :default => "0",  :null => false
    t.date    "retp_fecha",                                                          :null => false
    t.integer "retp_codregimen",                                   :default => 0,    :null => false
    t.float   "retp_importe",        :limit => 11,                 :default => 0.0,  :null => false
    t.integer "retp_nrocertificado",                               :default => 0,    :null => false
    t.string  "retp_usuario",        :limit => 8,                  :default => "",   :null => false
    t.date    "retp_ultmod",                                                         :null => false
  end

  create_table "revendedor", :id => false, :force => true do |t|
    t.integer "id_revendedor",                                             :null => false
    t.integer "reve_codigo",                              :default => 0,   :null => false
    t.integer "id_vendedor",                              :default => 0,   :null => false
    t.string  "reve_nombre",     :limit => 30,                             :null => false
    t.string  "reve_domicilio",  :limit => 50,                             :null => false
    t.integer "id_sucursal",     :limit => 1,             :default => 0,   :null => false
    t.integer "id_cliente",                                                :null => false
    t.integer "id_jurisdiccion",                                           :null => false
    t.enum    "reve_ncogasto",   :limit => [:NC, :GASTO], :default => :NC, :null => false
    t.string  "reve_usuario",    :limit => 8,                              :null => false
    t.date    "reve_ultmod",                                               :null => false
  end

  add_index "revendedor", ["id_sucursal", "reve_codigo"], :name => "por_codigo"
  add_index "revendedor", ["id_sucursal"], :name => "por_cliente"

  create_table "revendedors", :id => false, :force => true do |t|
    t.integer "id",                                          :null => false
    t.integer "reve_codigo",                  :default => 0, :null => false
    t.integer "vendedor_id",                  :default => 0, :null => false
    t.string  "reve_nombre",    :limit => 30,                :null => false
    t.string  "reve_domicilio", :limit => 50,                :null => false
    t.integer "sucursal_id",    :limit => 1,  :default => 0, :null => false
    t.integer "cliente_id",                                  :null => false
    t.string  "reve_usuario",   :limit => 8,                 :null => false
    t.date    "reve_ultmod",                                 :null => false
  end

  create_table "roles", :force => true do |t|
    t.string "titulo"
  end

  create_table "roles_usuarios", :id => false, :force => true do |t|
    t.integer "role_id",    :default => 0, :null => false
    t.integer "usuario_id", :default => 0, :null => false
  end

  create_table "rubro", :primary_key => "id_rubro", :force => true do |t|
    t.integer "rubr_codigo",                          :default => 0,   :null => false
    t.integer "rubr_codigoviejo", :limit => 1,        :default => 0,   :null => false
    t.string  "rubr_descripcion", :limit => 30,       :default => "",  :null => false
    t.enum    "rubr_servicio",    :limit => [:N, :S], :default => :N,  :null => false
    t.float   "rubr_topeminimo",  :limit => 5,        :default => 0.0, :null => false
    t.float   "rubr_topemaximo",  :limit => 5,        :default => 0.0, :null => false
    t.string  "rubr_usuario",     :limit => 8,        :default => "",  :null => false
    t.date    "rubr_ultmod",                                           :null => false
  end

  add_index "rubro", ["rubr_codigo"], :name => "rubr_codigo"

  create_table "rubros", :id => false, :force => true do |t|
    t.integer "id",                                   :default => 0,   :null => false
    t.integer "rubr_codigo",                          :default => 0,   :null => false
    t.integer "rubr_codigoviejo", :limit => 1,        :default => 0,   :null => false
    t.string  "rubr_descripcion", :limit => 30,       :default => "",  :null => false
    t.enum    "rubr_servicio",    :limit => [:N, :S], :default => :N,  :null => false
    t.float   "rubr_topeminimo",  :limit => 5,        :default => 0.0, :null => false
    t.float   "rubr_topemaximo",  :limit => 5,        :default => 0.0, :null => false
    t.string  "rubr_usuario",     :limit => 8,        :default => "",  :null => false
    t.date    "rubr_ultmod",                                           :null => false
  end

  create_table "situacionafip", :primary_key => "id_situacionafip", :force => true do |t|
    t.integer "situ_codigo",       :limit => 1,                                :default => 0,  :null => false
    t.string  "situ_nombre",       :limit => 20,                               :default => "", :null => false
    t.string  "situ_abreviatura",  :limit => 4,                                :default => "", :null => false
    t.enum    "situ_tasageneral",  :limit => [:S, :N],                         :default => :S, :null => false
    t.enum    "situ_sobretasa",    :limit => [:N, :S],                         :default => :N, :null => false
    t.enum    "situ_discrimina",   :limit => [:S, :N],                         :default => :S, :null => false
    t.enum    "situ_letra",        :limit => [:I, :N, :E, :A, :C, :B, :M, :T], :default => :I, :null => false
    t.enum    "situ_controlacuit", :limit => [:S, :N],                         :default => :S, :null => false
    t.string  "situ_usuario",      :limit => 8,                                :default => "", :null => false
    t.date    "situ_ultmod",                                                                   :null => false
  end

  add_index "situacionafip", ["situ_codigo"], :name => "situ_codigo", :unique => true

  create_table "situacionafips", :id => false, :force => true do |t|
    t.integer "id",                :limit => 1,                                :default => 0,  :null => false
    t.integer "situ_codigo",       :limit => 1,                                :default => 0,  :null => false
    t.string  "situ_nombre",       :limit => 20,                               :default => "", :null => false
    t.string  "situ_abreviatura",  :limit => 4,                                :default => "", :null => false
    t.enum    "situ_tasageneral",  :limit => [:S, :N],                         :default => :S, :null => false
    t.enum    "situ_sobretasa",    :limit => [:N, :S],                         :default => :N, :null => false
    t.enum    "situ_discrimina",   :limit => [:S, :N],                         :default => :S, :null => false
    t.enum    "situ_letra",        :limit => [:I, :N, :E, :A, :C, :B, :M, :T], :default => :I, :null => false
    t.enum    "situ_controlacuit", :limit => [:S, :N],                         :default => :S, :null => false
    t.string  "situ_usuario",      :limit => 8,                                :default => "", :null => false
    t.date    "situ_ultmod",                                                                   :null => false
  end

  create_table "stock", :id => false, :force => true do |t|
    t.integer "id_sucursal",       :limit => 1,   :default => 0,  :null => false
    t.integer "id_articulo",       :limit => 8,   :default => 0,  :null => false
    t.integer "stoc_actual",                      :default => 0,  :null => false
    t.integer "stoc_minimo",                      :default => 0,  :null => false
    t.integer "stoc_critico",                     :default => 0,  :null => false
    t.integer "stoc_inicial",                     :default => 0,  :null => false
    t.string  "stoc_transito",     :limit => 100, :default => "", :null => false
    t.date    "stoc_fechainicial",                                :null => false
    t.string  "stoc_usuario",      :limit => 8,   :default => "", :null => false
    t.date    "stoc_ultmod",                                      :null => false
  end

  create_table "sucursal", :primary_key => "id_sucursal", :force => true do |t|
    t.integer "sucu_codigo",            :limit => 1,        :default => 0,  :null => false
    t.string  "sucu_nombre",            :limit => 15,       :default => "", :null => false
    t.string  "sucu_abreviatura",       :limit => 6,        :default => "", :null => false
    t.string  "sucu_domicilio",         :limit => 50,       :default => "", :null => false
    t.string  "sucu_telefono",          :limit => 50,       :default => "", :null => false
    t.string  "sucu_impu_municipal",    :limit => 20,       :default => "", :null => false
    t.string  "sucu_insc_municipal",    :limit => 20,       :default => "", :null => false
    t.string  "sucu_provinciapib",      :limit => 6,                        :null => false
    t.date    "sucu_inicioactividades",                                     :null => false
    t.enum    "sucu_porcuentayorden",   :limit => [:N, :S], :default => :N, :null => false
    t.enum    "sucu_controlaservicio",  :limit => [:N, :S], :default => :N, :null => false
    t.string  "sucu_email",             :limit => 50,       :default => "", :null => false
    t.string  "sucu_emailpedidoweb",    :limit => 50,                       :null => false
    t.string  "sucu_usuario",           :limit => 8,        :default => "", :null => false
    t.date    "sucu_ultmod",                                                :null => false
  end

  add_index "sucursal", ["sucu_codigo"], :name => "porcodigo", :unique => true

  create_table "sucursals", :id => false, :force => true do |t|
    t.integer "id",                     :limit => 1,        :default => 0,  :null => false
    t.integer "sucu_codigo",            :limit => 1,        :default => 0,  :null => false
    t.string  "sucu_nombre",            :limit => 15,       :default => "", :null => false
    t.string  "sucu_abreviatura",       :limit => 6,        :default => "", :null => false
    t.string  "sucu_domicilio",         :limit => 50,       :default => "", :null => false
    t.string  "sucu_telefono",          :limit => 50,       :default => "", :null => false
    t.string  "sucu_impu_municipal",    :limit => 20,       :default => "", :null => false
    t.string  "sucu_insc_municipal",    :limit => 20,       :default => "", :null => false
    t.string  "sucu_provinciapib",      :limit => 6,                        :null => false
    t.date    "sucu_inicioactividades",                                     :null => false
    t.enum    "sucu_porcuentayorden",   :limit => [:N, :S], :default => :N, :null => false
    t.enum    "sucu_controlaservicio",  :limit => [:N, :S], :default => :N, :null => false
    t.string  "sucu_email",             :limit => 50,       :default => "", :null => false
    t.string  "sucu_emailpedidoweb",    :limit => 50,                       :null => false
    t.string  "sucu_usuario",           :limit => 8,        :default => "", :null => false
    t.date    "sucu_ultmod",                                                :null => false
  end

  create_table "sucuservers", :force => true do |t|
    t.integer "sucursal_id",                :null => false
    t.string  "sucs_host",    :limit => 40, :null => false
    t.string  "sucs_usuario", :limit => 10, :null => false
    t.string  "sucs_clave",   :limit => 10, :null => false
  end

  create_table "tarjetacredito", :primary_key => "id_tarjetacredito", :force => true do |t|
    t.integer "tarj_codigo",     :limit => 1,        :default => 0,  :null => false
    t.string  "tarj_nombre",     :limit => 15,       :default => "", :null => false
    t.integer "id_banco",                            :default => 0,  :null => false
    t.enum    "tarj_habilitada", :limit => [:S, :N], :default => :S
    t.string  "tarj_usuario",    :limit => 8,        :default => "", :null => false
    t.date    "tarj_ultmod",                                         :null => false
  end

  add_index "tarjetacredito", ["tarj_codigo"], :name => "porcodigo", :unique => true

  create_table "tipocomprobante", :primary_key => "id_tipocomprobante", :force => true do |t|
    t.integer "tcom_codigo",                                                  :default => 0,  :null => false
    t.string  "tcom_nombre",          :limit => 30,                                           :null => false
    t.enum    "tcom_discriminaiva",   :limit => [:Si, :No]
    t.enum    "tcom_validanro",       :limit => [:N, :S],                     :default => :S
    t.enum    "tcom_ambitocompra",    :limit => [:N, :S],                     :default => :S
    t.enum    "tcom_letra",           :limit => [:A, :B, :C, :X, :R, :E, :M], :default => :A, :null => false
    t.string  "tcom_abreviatura",     :limit => 4,                            :default => "", :null => false
    t.string  "tcom_sumaresta",       :limit => 1,                            :default => "", :null => false
    t.string  "tcom_afecta",          :limit => 1,                            :default => "", :null => false
    t.integer "tcom_copias",          :limit => 1,                            :default => 0,  :null => false
    t.enum    "tcom_tdf",             :limit => [:F, :D, :C, :R, :E, :L],     :default => :F, :null => false
    t.string  "tcom_tipocomprobante", :limit => 1,                            :default => "", :null => false
    t.integer "tcom_aperturacomp",    :limit => 1,                            :default => 0,  :null => false
    t.integer "tcom_cierrecomp",      :limit => 1,                            :default => 0,  :null => false
    t.string  "tcom_usuario",         :limit => 8,                            :default => "", :null => false
    t.date    "tcom_ultmod",                                                                  :null => false
  end

  create_table "tipocomprobantes", :id => false, :force => true do |t|
    t.integer "id",                                                           :default => 0,  :null => false
    t.integer "tcom_codigo",                                                  :default => 0,  :null => false
    t.string  "tcom_nombre",          :limit => 30,                                           :null => false
    t.enum    "tcom_discriminaiva",   :limit => [:Si, :No]
    t.enum    "tcom_validanro",       :limit => [:N, :S],                     :default => :S
    t.enum    "tcom_ambitocompra",    :limit => [:N, :S],                     :default => :S
    t.enum    "tcom_letra",           :limit => [:A, :B, :C, :X, :R, :E, :M], :default => :A, :null => false
    t.string  "tcom_abreviatura",     :limit => 4,                            :default => "", :null => false
    t.string  "tcom_sumaresta",       :limit => 1,                            :default => "", :null => false
    t.string  "tcom_afecta",          :limit => 1,                            :default => "", :null => false
    t.integer "tcom_copias",          :limit => 1,                            :default => 0,  :null => false
    t.enum    "tcom_tdf",             :limit => [:F, :D, :C, :R, :E, :L],     :default => :F, :null => false
    t.string  "tcom_tipocomprobante", :limit => 1,                            :default => "", :null => false
    t.integer "tcom_aperturacomp",    :limit => 1,                            :default => 0,  :null => false
    t.integer "tcom_cierrecomp",      :limit => 1,                            :default => 0,  :null => false
    t.string  "tcom_usuario",         :limit => 8,                            :default => "", :null => false
    t.date    "tcom_ultmod",                                                                  :null => false
  end

  create_table "tipodocumento", :primary_key => "id_tipodocumento", :force => true do |t|
    t.integer "tdoc_codigo",      :limit => 1,  :default => 0,  :null => false
    t.string  "tdoc_nombre",      :limit => 20, :default => "", :null => false
    t.string  "tdoc_abreviatura", :limit => 4,  :default => "", :null => false
    t.string  "tdoc_tdi",         :limit => 1,  :default => "", :null => false
    t.string  "tdoc_usuario",     :limit => 8,  :default => "", :null => false
    t.date    "tdoc_ultmod",                                    :null => false
  end

  create_table "tipodocumentos", :id => false, :force => true do |t|
    t.integer "id",               :limit => 1,  :default => 0,  :null => false
    t.integer "tdoc_codigo",      :limit => 1,  :default => 0,  :null => false
    t.string  "tdoc_nombre",      :limit => 20, :default => "", :null => false
    t.string  "tdoc_abreviatura", :limit => 4,  :default => "", :null => false
    t.string  "tdoc_tdi",         :limit => 1,  :default => "", :null => false
    t.string  "tdoc_usuario",     :limit => 8,  :default => "", :null => false
    t.date    "tdoc_ultmod",                                    :null => false
  end

  create_table "tiposconstancia", :primary_key => "id_tiposconstancia", :force => true do |t|
    t.string "tcon_detalle",     :limit => 30, :default => "", :null => false
    t.string "tcon_abreviatura", :limit => 3,  :default => "", :null => false
  end

  create_table "tiposconstancias", :id => false, :force => true do |t|
    t.integer "id",                             :default => 0,  :null => false
    t.string  "tcon_detalle",     :limit => 30, :default => "", :null => false
    t.string  "tcon_abreviatura", :limit => 3,  :default => "", :null => false
  end

  create_table "topedescuento", :id => false, :force => true do |t|
    t.integer "id_rubro",                     :default => 0,   :null => false
    t.integer "id_marca",                     :default => 0,   :null => false
    t.float   "tdes_topeminimo", :limit => 6, :default => 0.0, :null => false
    t.float   "tdes_topemaximo", :limit => 6, :default => 0.0, :null => false
  end

  add_index "topedescuento", ["id_rubro", "id_marca"], :name => "rubrmarc", :unique => true

  create_table "trabajostaller", :primary_key => "id_trabajostaller", :force => true do |t|
    t.integer "id_sucursal",                         :default => 0,  :null => false
    t.string  "id_autos",              :limit => 6,  :default => "", :null => false
    t.date    "trat_fechatrabajo",                                   :null => false
    t.integer "trat_kmtrabajo",                      :default => 0,  :null => false
    t.string  "trat_trendelconvdiv",   :limit => 10, :default => "", :null => false
    t.string  "trat_trendelcombader",  :limit => 10, :default => "", :null => false
    t.string  "trat_trendelcombaizq",  :limit => 10, :default => "", :null => false
    t.string  "trat_trendelavance",    :limit => 10, :default => "", :null => false
    t.string  "trat_trentraconvdiv",   :limit => 10, :default => "", :null => false
    t.string  "trat_trentracombader",  :limit => 10, :default => "", :null => false
    t.string  "trat_trentracombaizq",  :limit => 10, :default => "", :null => false
    t.string  "trat_manoobra1",        :limit => 70, :default => "", :null => false
    t.string  "trat_manoobra2",        :limit => 70, :default => "", :null => false
    t.string  "trat_manoobra3",        :limit => 70, :default => "", :null => false
    t.date    "trat_fechapresupuesto",                               :null => false
    t.integer "trat_kmpresupuesto",                  :default => 0,  :null => false
    t.string  "trat_repuestos1",       :limit => 70, :default => "", :null => false
    t.string  "trat_repuestos2",       :limit => 70, :default => "", :null => false
    t.string  "trat_repuestos3",       :limit => 70, :default => "", :null => false
    t.string  "trat_manobra1",         :limit => 70, :default => "", :null => false
    t.string  "trat_manobra2",         :limit => 70, :default => "", :null => false
    t.string  "trat_manobra3",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa1",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa2",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa3",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa4",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa5",         :limit => 70, :default => "", :null => false
    t.string  "trat_operario",         :limit => 20, :default => "", :null => false
    t.string  "trat_usuario",          :limit => 8,  :default => "", :null => false
    t.date    "trat_ultmod",                                         :null => false
  end

  add_index "trabajostaller", ["id_trabajostaller"], :name => "id_trabajostaller", :unique => true

  create_table "trabajostalleres", :id => false, :force => true do |t|
    t.integer "id",                    :limit => 8,  :default => 0,  :null => false
    t.integer "sucursal_id",                         :default => 0,  :null => false
    t.string  "autos_id",              :limit => 6,  :default => "", :null => false
    t.date    "trat_fechatrabajo",                                   :null => false
    t.integer "trat_kmtrabajo",                      :default => 0,  :null => false
    t.string  "trat_trendelconvdiv",   :limit => 10, :default => "", :null => false
    t.string  "trat_trendelcombader",  :limit => 10, :default => "", :null => false
    t.string  "trat_trendelcombaizq",  :limit => 10, :default => "", :null => false
    t.string  "trat_trendelavance",    :limit => 10, :default => "", :null => false
    t.string  "trat_trentraconvdiv",   :limit => 10, :default => "", :null => false
    t.string  "trat_trentracombader",  :limit => 10, :default => "", :null => false
    t.string  "trat_trentracombaizq",  :limit => 10, :default => "", :null => false
    t.string  "trat_manoobra1",        :limit => 70, :default => "", :null => false
    t.string  "trat_manoobra2",        :limit => 70, :default => "", :null => false
    t.string  "trat_manoobra3",        :limit => 70, :default => "", :null => false
    t.date    "trat_fechapresupuesto",                               :null => false
    t.integer "trat_kmpresupuesto",                  :default => 0,  :null => false
    t.string  "trat_repuestos1",       :limit => 70, :default => "", :null => false
    t.string  "trat_repuestos2",       :limit => 70, :default => "", :null => false
    t.string  "trat_repuestos3",       :limit => 70, :default => "", :null => false
    t.string  "trat_manobra1",         :limit => 70, :default => "", :null => false
    t.string  "trat_manobra2",         :limit => 70, :default => "", :null => false
    t.string  "trat_manobra3",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa1",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa2",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa3",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa4",         :limit => 70, :default => "", :null => false
    t.string  "trat_observa5",         :limit => 70, :default => "", :null => false
    t.string  "trat_operario",         :limit => 20, :default => "", :null => false
    t.string  "trat_usuario",          :limit => 8,  :default => "", :null => false
    t.date    "trat_ultmod",                                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",            :limit => 100
    t.string   "login"
    t.string   "hashed_password"
    t.string   "email"
    t.string   "salt"
    t.datetime "created_at"
  end

  create_table "usuario", :force => true do |t|
    t.string  "usur_usuario",    :limit => 10, :default => "", :null => false
    t.string  "usur_rol",        :limit => 10, :default => "", :null => false
    t.integer "usur_nivelmenu",  :limit => 1
    t.string  "usur_nombre",     :limit => 30, :default => "", :null => false
    t.string  "usur_contrasena", :limit => 50
    t.string  "usur_email",      :limit => 50
    t.integer "sucursal_id",     :limit => 1
    t.integer "cliente_id"
    t.integer "usur_nivel",                    :default => 0,  :null => false
  end

  create_table "usuarios", :id => false, :force => true do |t|
    t.integer "id",                            :default => 0,  :null => false
    t.string  "usur_usuario",    :limit => 10, :default => "", :null => false
    t.string  "usur_rol",        :limit => 10, :default => "", :null => false
    t.integer "usur_nivelmenu",  :limit => 1
    t.string  "usur_nombre",     :limit => 30, :default => "", :null => false
    t.string  "usur_contrasena", :limit => 50
    t.string  "usur_email",      :limit => 50
    t.integer "sucursal_id",     :limit => 1
    t.integer "cliente_id"
    t.integer "usur_nivel",                    :default => 0,  :null => false
  end

  create_table "vendedor", :primary_key => "id_vendedor", :force => true do |t|
    t.integer "vend_codigo",                                  :default => 0,   :null => false
    t.string  "vend_nombre",            :limit => 30,         :default => "",  :null => false
    t.string  "vend_nombreabrev",       :limit => 11,         :default => "",  :null => false
    t.string  "vend_domicilio",         :limit => 50,         :default => "",  :null => false
    t.integer "id_sucursal",            :limit => 1,          :default => 0,   :null => false
    t.enum    "vend_confeccionacaja",   :limit => [:S, :N],   :default => :S
    t.integer "vend_agrupaconvendedor",                       :default => 0
    t.string  "vend_remuneracion",      :limit => 100
    t.float   "vend_comisionventas",    :limit => 5,          :default => 0.0
    t.float   "vend_comisioncobran",    :limit => 5,          :default => 0.0
    t.string  "vend_zona",              :limit => 100
    t.string  "vend_mercaderia",        :limit => 100
    t.date    "vend_ingreso"
    t.enum    "vend_local",             :limit => [:No, :Si]
    t.string  "vend_usuario",           :limit => 8
    t.date    "vend_ultmod"
  end

  add_index "vendedor", ["vend_codigo"], :name => "vend_codigo"

  create_table "vendedores", :id => false, :force => true do |t|
    t.integer "id",                                           :default => 0,   :null => false
    t.integer "vend_codigo",                                  :default => 0,   :null => false
    t.string  "vend_nombre",            :limit => 30,         :default => "",  :null => false
    t.string  "vend_nombreabrev",       :limit => 11,         :default => "",  :null => false
    t.string  "vend_domicilio",         :limit => 50,         :default => "",  :null => false
    t.integer "sucursal_id",            :limit => 1,          :default => 0,   :null => false
    t.enum    "vend_confeccionacaja",   :limit => [:S, :N],   :default => :S
    t.integer "vend_agrupaconvendedor",                       :default => 0
    t.string  "vend_remuneracion",      :limit => 100
    t.float   "vend_comisionventas",    :limit => 5,          :default => 0.0
    t.float   "vend_comisioncobran",    :limit => 5,          :default => 0.0
    t.string  "vend_zona",              :limit => 100
    t.string  "vend_mercaderia",        :limit => 100
    t.date    "vend_ingreso"
    t.enum    "vend_local",             :limit => [:No, :Si]
    t.string  "vend_usuario",           :limit => 8
    t.date    "vend_ultmod"
  end

  create_table "vendedors", :id => false, :force => true do |t|
    t.integer "id",                                           :default => 0,   :null => false
    t.integer "vend_codigo",                                  :default => 0,   :null => false
    t.string  "vend_nombre",            :limit => 30,         :default => "",  :null => false
    t.string  "vend_nombreabrev",       :limit => 11,         :default => "",  :null => false
    t.string  "vend_domicilio",         :limit => 50,         :default => "",  :null => false
    t.integer "sucursal_id",            :limit => 1,          :default => 0,   :null => false
    t.enum    "vend_confeccionacaja",   :limit => [:S, :N],   :default => :S
    t.integer "vend_agrupaconvendedor",                       :default => 0
    t.string  "vend_remuneracion",      :limit => 100
    t.float   "vend_comisionventas",    :limit => 5,          :default => 0.0
    t.float   "vend_comisioncobran",    :limit => 5,          :default => 0.0
    t.string  "vend_zona",              :limit => 100
    t.string  "vend_mercaderia",        :limit => 100
    t.date    "vend_ingreso"
    t.enum    "vend_local",             :limit => [:No, :Si]
    t.string  "vend_usuario",           :limit => 8
    t.date    "vend_ultmod"
  end

  create_table "ventaxalicuota", :id => false, :force => true do |t|
    t.integer "id_sucursal",      :limit => 1,                                :null => false
    t.integer "id_cabfactura",    :limit => 8,                                :null => false
    t.integer "id_alicuotaiva",   :limit => 1,                                :null => false
    t.decimal "vali_netogravado",              :precision => 13, :scale => 2, :null => false
    t.decimal "vali_iva",                      :precision => 13, :scale => 2, :null => false
    t.decimal "vali_total",                    :precision => 13, :scale => 2, :null => false
  end

  add_index "ventaxalicuota", ["id_sucursal", "id_cabfactura"], :name => "por_cabfactura"

end
