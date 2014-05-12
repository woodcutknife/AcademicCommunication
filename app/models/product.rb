class Product < ActiveRecord::Base
  belongs_to :contest
  has_many :profiles, dependent: :destroy
  has_many :accounts, through: :profiles
  has_one :form, dependent: :destroy
end
