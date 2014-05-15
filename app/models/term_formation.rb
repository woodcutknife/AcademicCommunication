class TermFormation < ActiveRecord::Base
  belongs_to :form_formation
  has_many :terms

  validates_presence_of :name
end
