class AddTextValueToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :text_value, :text
  end
end
