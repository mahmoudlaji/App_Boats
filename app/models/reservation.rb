class Reservation < ApplicationRecord
  validates :name, :last_name, :email, presence: :true, uniqueness: :true
  validates :start_date, :end_date, presence: :true

  belongs_to :boat
  belongs_to :user
end
