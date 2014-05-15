class RemoveAttachmentFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :attachment, :string
  end
end
