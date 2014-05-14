class AddTermFormationReferencesToTerms < ActiveRecord::Migration
  def change
    add_reference :terms, :term_formation, index: true
  end
end
