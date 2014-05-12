class AddFormFormationReferencesToTermFormations < ActiveRecord::Migration
  def change
    add_reference :term_formations, :form_formation, index: true
  end
end
