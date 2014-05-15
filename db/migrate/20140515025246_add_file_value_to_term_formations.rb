class AddFileValueToTermFormations < ActiveRecord::Migration
  def change
    add_column :term_formations, :file_value, :string
  end
end
