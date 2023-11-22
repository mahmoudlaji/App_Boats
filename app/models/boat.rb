class Boat < ApplicationRecord
  has_one_attached :photo
  has_many_attached :photos

  CATEGORIES = ["Motorship", "Sailboat", "Yacht", "Catamaran", "JetSki"]
  validates :name, :address, presence: :true, uniqueness: :true
  validates :description, :price, presence: :true
  validates :category, presence: :true, inclusion: { in: CATEGORIES }
end
