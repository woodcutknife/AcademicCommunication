class AccountsHaveAndBelongToManyRoles < ActiveRecord::Migration
  def self.up
    create_table :accounts_roles, :id => false do |t|
      t.references :account, :role
    end
  end

  def self.down
    drop_table :accounts_roles
  end
end
