class GroceryListGroup < ApplicationRecord
  belongs_to :grocery_list
  has_many :grocery_list_items, dependent: :destroy	
  validates :name, presence: true
end
