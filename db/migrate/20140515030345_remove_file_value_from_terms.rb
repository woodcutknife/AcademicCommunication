class RemoveFileValueFromTerms < ActiveRecord::Migration
  def change
    remove_column :terms, :file_value, :string
  end
end
