class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.references :form, index: true

      t.timestamps
    end
  end
end
