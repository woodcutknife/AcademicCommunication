class AddTypeToTermFormations < ActiveRecord::Migration
  def change
    add_column :term_formations, :type, :string
  end
end
