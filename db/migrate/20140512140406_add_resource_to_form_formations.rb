class AddResourceToFormFormations < ActiveRecord::Migration
  def change
    add_column :form_formations, :resource, :string
  end
end
