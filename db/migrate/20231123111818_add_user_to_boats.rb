class AddUserToBoats < ActiveRecord::Migration[6.1]
  def change
    add_reference :boats, :user, null: true, foreign_key: true
  end
end
