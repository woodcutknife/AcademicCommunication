class ContestCategory < ActiveRecord::Base
  has_and_belongs_to_many :admins, class_name: "Account"
  has_many :contests, dependent: :destroy
end
