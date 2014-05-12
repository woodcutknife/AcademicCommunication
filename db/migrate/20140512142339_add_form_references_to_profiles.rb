class AddFormReferencesToProfiles < ActiveRecord::Migration
  def change
    add_reference :profiles, :form, index: true
  end
end
