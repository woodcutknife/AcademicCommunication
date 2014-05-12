class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :roles
  has_and_belongs_to_many :contest_categories
  after_create :set_default_role

  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end

  private

  def set_default_role
    self.roles << Role.where(:name => 'User').first
  end
end
