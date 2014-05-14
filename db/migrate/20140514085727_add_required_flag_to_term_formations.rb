class AddRequiredFlagToTermFormations < ActiveRecord::Migration
  def change
    add_column :term_formations, :required, :boolean
  end
end
