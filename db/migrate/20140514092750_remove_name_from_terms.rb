class RemoveNameFromTerms < ActiveRecord::Migration
  def change
    remove_column :terms, :name, :string
  end
end
