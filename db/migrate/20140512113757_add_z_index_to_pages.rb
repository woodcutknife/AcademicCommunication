class AddZIndexToPages < ActiveRecord::Migration
  def change
    add_column :pages, :z_index, :integer
  end
end
