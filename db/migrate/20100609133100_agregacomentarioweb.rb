class Agregacomentarioweb < ActiveRecord::Migration
  def self.up
    add_column "maestrolistas", "mlis_comentarioweb",:string 
  end

  def self.down
    remove_column "maestrolista", "mlis_comentarioweb"
  end
end
