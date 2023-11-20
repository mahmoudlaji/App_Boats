class Boat < ApplicationRecord
  CATEGORIES = ["Motorship", "Sailboat", "Yacht", "Catamaran"]
  validates :name, :address, presence: :true, uniqueness: :true
  validates :description, :price, presence: :true
  validates :category, presence: :true, inclusion: { in: CATEGORIES }
end
