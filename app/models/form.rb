class Form < ActiveRecord::Base
  belongs_to :product
  belongs_to :profile
  has_many :terms, dependent: :destroy
end
