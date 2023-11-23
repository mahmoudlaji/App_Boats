class Boat < ApplicationRecord
  has_one_attached :photo
  has_many_attached :photos

  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations
  belongs_to :user

  CATEGORIES = ["Motorship", "Sailboat", "Yacht", "Catamaran", "JetSki"]
  validates :name, :address, presence: :true, uniqueness: :true
  validates :description, :price, presence: :true
  validates :category, presence: :true, inclusion: { in: CATEGORIES }
end
