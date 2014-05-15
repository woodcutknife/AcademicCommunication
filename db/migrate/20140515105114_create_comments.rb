class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.references :topic, index: true
      t.references :account, index: true

      t.timestamps
    end
  end
end
