class FormFormation < ActiveRecord::Base
  belongs_to :contest
  has_many :term_formations, dependent: :destroy

  accepts_nested_attributes_for :term_formations, reject_if: :all_blank, allow_destroy: true
end
