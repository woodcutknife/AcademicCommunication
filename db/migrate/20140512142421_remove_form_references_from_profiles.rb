class RemoveFormReferencesFromProfiles < ActiveRecord::Migration
  def change
    remove_reference :profiles, :form, index: true
  end
end
