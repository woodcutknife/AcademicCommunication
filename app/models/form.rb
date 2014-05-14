class Form < ActiveRecord::Base
  belongs_to :product
  belongs_to :profile
  belongs_to :result
  has_many :terms, dependent: :destroy
end
