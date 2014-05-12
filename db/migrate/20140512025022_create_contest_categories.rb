class CreateContestCategories < ActiveRecord::Migration
  def change
    create_table :contest_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end
