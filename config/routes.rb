Rails.application.routes.draw do
	namespace :api do
	  	namespace :v1 do      
			resources :grocery_lists do
				resources :grocery_list_groups do
					resources :grocery_list_items
				end
			end
			post "create_full_list", controller: :grocery_lists, action: :create_full_list
			patch "edit_full_list/:id", controller: :grocery_lists, action: :edit_full_list

    		resources :settings
    		get "settings/code/:code", controller: :settings, action: :show_by_code
		end
	end

	root to: "home#index"

	get "user", controller: :signin, action: :show
	post "refresh", controller: :refresh, action: :create
	post "signup", controller: :signup, action: :create
	post "signin", controller: :signin, action: :create
	delete "signin", controller: :signin, action: :destroy
	patch "signin", controller: :signin, action: :update

end