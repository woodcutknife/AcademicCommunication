class ProductCategory < ActiveRecord::Base
  belongs_to :contest
  has_many :products, dependent: :destroy
end
