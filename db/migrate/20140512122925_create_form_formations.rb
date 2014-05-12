class CreateFormFormations < ActiveRecord::Migration
  def change
    create_table :form_formations do |t|
      t.references :contest, index: true

      t.timestamps
    end
  end
end
