class GroceryList < ApplicationRecord
  belongs_to :user
  has_many :grocery_list_groups,->{order 'grocery_list_groups.sort'}, dependent: :destroy
  has_many :grocery_list_items, through: :grocery_list_groups	
  validates :name, presence: true
  accepts_nested_attributes_for :grocery_list_items
end
