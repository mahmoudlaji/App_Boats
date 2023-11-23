class AddBoatToReservations < ActiveRecord::Migration[7.0]
  def change
    add_reference :reservations, :boat, null: false, foreign_key: true
  end
end
