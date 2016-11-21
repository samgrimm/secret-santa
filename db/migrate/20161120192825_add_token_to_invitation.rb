class AddTokenToInvitation < ActiveRecord::Migration[5.0]
  def change
    add_column :invitations, :token, :string
  end
end
