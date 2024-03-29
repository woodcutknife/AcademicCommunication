class Contest < ActiveRecord::Base
  belongs_to :contest_category
  has_many :pages, dependent: :destroy
  has_many :form_formations, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :forum, dependent: :destroy
end
