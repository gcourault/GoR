class Coeficiente < ActiveRecord::Base
 belongs_to :ejercicio

validates_numericality_of :coef_inicial, :coef_mes1, :coef_mes2, :coef_mes3, :coef_mes4, :coef_mes5, :coef_mes6, :coef_mes7, :coef_mes8, :coef_mes9, :coef_mes10, :coef_mes11, :coef_mes12, :greater_than_or_equal_to => 0, :message => "El coeficiente debe ser cero o algún valor" 
end
