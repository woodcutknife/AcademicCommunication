class CreateTermFormations < ActiveRecord::Migration
  def change
    create_table :term_formations do |t|

      t.timestamps
    end
  end
end
