class CreateEjercicios < ActiveRecord::Migration
  def self.up
    create_table :ejercicios do |t|
      t.date :ejer_desde
      t.date :ejer_hasta
      t.string :ejer_descripcion
      t.string :ejer_cerrado

      t.timestamps
    end
  end

  def self.down
    drop_table :ejercicios
  end
end
