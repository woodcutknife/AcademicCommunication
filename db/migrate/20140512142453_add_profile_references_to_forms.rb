class AddProfileReferencesToForms < ActiveRecord::Migration
  def change
    add_reference :forms, :profile, index: true
  end
end
