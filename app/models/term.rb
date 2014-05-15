class Term < ActiveRecord::Base
  belongs_to :form
  belongs_to :term_formation
  mount_uploader :file_value, AttachmentUploader
end
