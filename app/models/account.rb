class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :contest_categories
  has_many :profiles, dependent: :destroy
  has_many :products, through: :profiles
  has_many :results, dependent: :destroy
  has_many :tasks, through: :results, class_name: 'Product'
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy

  after_create :set_default_role

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  private

  def set_default_role
    self.roles << Role.where(:name => 'User').first unless self.role?(:super_admin)
  end
end
