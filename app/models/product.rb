class Product < ActiveRecord::Base
  belongs_to :contest
  has_many :profiles, dependent: :destroy
  has_many :accounts, through: :profiles
end
