class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
