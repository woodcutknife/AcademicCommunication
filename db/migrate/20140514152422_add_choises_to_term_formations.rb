class AddChoisesToTermFormations < ActiveRecord::Migration
  def change
    add_column :term_formations, :choises, :string
  end
end
