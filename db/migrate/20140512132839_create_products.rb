class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.references :contest, index: true
      t.references :account, index: true

      t.timestamps
    end
  end
end
