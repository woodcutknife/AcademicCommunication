class AddResultReferencesToForms < ActiveRecord::Migration
  def change
    add_reference :forms, :result, index: true
  end
end
