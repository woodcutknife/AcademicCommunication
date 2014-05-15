class Forum < ActiveRecord::Base
  belongs_to :contest
  has_many :topics, dependent: :destroy
end
