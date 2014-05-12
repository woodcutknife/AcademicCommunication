class Contest < ActiveRecord::Base
  belongs_to :contest_category
  has_many :pages, dependent: :destroy
end
