class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :content
      t.references :contest, index: true

      t.timestamps
    end
  end
end
