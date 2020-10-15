class GroceryListItem < ApplicationRecord
  belongs_to :grocery_list_group
  has_one :grocery_list, through: :grocery_list_group
  validates :name, presence: true
  validates :cost, presence: true
end
