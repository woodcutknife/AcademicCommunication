class CreateForums < ActiveRecord::Migration
  def change
    create_table :forums do |t|
      t.references :contest, index: true

      t.timestamps
    end
  end
end
