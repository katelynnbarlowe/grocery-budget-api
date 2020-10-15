class User < ApplicationRecord
	has_secure_password 
	has_many :settings
	has_many :grocery_lists
end