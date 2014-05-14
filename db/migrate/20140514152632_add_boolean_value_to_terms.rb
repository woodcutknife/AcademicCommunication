class AddBooleanValueToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :boolean_value, :boolean
  end
end
