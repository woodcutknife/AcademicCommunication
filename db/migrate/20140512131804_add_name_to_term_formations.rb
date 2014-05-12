class AddNameToTermFormations < ActiveRecord::Migration
  def change
    add_column :term_formations, :name, :string
  end
end
