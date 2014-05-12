class AddDefaultFlagToPages < ActiveRecord::Migration
  def change
    add_column :pages, :default, :boolean
  end
end
