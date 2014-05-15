class AddUploadFlagToContests < ActiveRecord::Migration
  def change
    add_column :contests, :upload, :boolean
  end
end
