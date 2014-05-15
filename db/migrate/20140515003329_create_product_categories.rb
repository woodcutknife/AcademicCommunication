class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.string :name
      t.string :slug
      t.references :contest, index: true

      t.timestamps
    end
  end
end
