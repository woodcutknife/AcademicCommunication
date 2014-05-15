class AddIntegerValueToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :integer_value, :integer
  end
end
