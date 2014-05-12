class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.string :name
      t.references :contest_category, index: true

      t.timestamps
    end
  end
end
