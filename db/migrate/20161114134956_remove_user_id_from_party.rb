class RemoveUserIdFromParty < ActiveRecord::Migration[5.0]
  def change
    remove_column :parties, :user_id, :integer
  end
end
