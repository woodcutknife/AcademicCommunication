class CreateForms < ActiveRecord::Migration
  def change
    create_table :forms do |t|
      t.references :product, index: true

      t.timestamps
    end
  end
end
