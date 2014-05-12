class ContestCategoriesHavaAndBelongToManyAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts_contest_categories, :id => false do |t|
      t.references :account, :contest_category
    end
  end

  def self.down
    drop_table :accounts_contest_categories
  end
end
