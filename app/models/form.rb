class Form < ActiveRecord::Base
  belongs_to :product
  has_many :terms, dependent: :destroy
end
