class AddReceipientToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :receipient_id, :integer
  end
end
