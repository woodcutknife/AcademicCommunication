class TermFormation < ActiveRecord::Base
  belongs_to :form_formation
  has_many :terms
end
