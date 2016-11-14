class AddOrganizerIdToParty < ActiveRecord::Migration[5.0]
  def change
    add_column :parties, :organizer_id, :integer
  end
end
