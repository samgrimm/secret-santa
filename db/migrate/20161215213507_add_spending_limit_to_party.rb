class AddSpendingLimitToParty < ActiveRecord::Migration[5.0]
  def change
    add_column :parties, :spending_limit, :decimal, precision: 8, scale: 2
  end
end
