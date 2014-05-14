class AddSingleFlagToTermFormations < ActiveRecord::Migration
  def change
    add_column :term_formations, :single, :boolean
  end
end
