class Contest < ActiveRecord::Base
  belongs_to :contest_category
  has_many :pages, dependent: :destroy
  has_one :form_formation, dependent: :destroy
  has_many :products, dependent: :destroy
end
