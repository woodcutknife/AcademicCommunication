class Result < ActiveRecord::Base
  belongs_to :judge, class_name: 'Account', foreign_key: 'account_id'
  belongs_to :task, class_name: 'Product', foreign_key: 'product_id'
end
