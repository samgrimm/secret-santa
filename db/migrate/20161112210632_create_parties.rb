class CreateParties < ActiveRecord::Migration[5.0]
  def change
    create_table :parties do |t|
      t.string :theme
      t.date :date
      t.time :time
      t.date :rsvp_deadline
      t.string :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
