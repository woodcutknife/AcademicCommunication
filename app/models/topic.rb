class Topic < ActiveRecord::Base
  belongs_to :account
  belongs_to :forum
  has_many :comments, dependent: :destroy
end
