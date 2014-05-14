class AddStringValueToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :string_value, :string
  end
end
