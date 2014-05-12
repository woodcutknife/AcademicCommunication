class Profile < ActiveRecord::Base
  belongs_to :account
  belongs_to :product
  has_one :form, dependent: :destroy
end
