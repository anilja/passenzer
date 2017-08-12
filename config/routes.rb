Rails.application.routes.draw do

  resources :bus_details
  get '/search_buses', to: "bus_details#search_buses"
  post '/change_bus', to: "bus_details#change_bus"
  post '/delete_selected_bus', to: "bus_details#delete_selected_bus"
  devise_for :users
  resources :busforms do
      resources :stops do
      end
    end  


      root "busforms#index"

  get 'new/signup'=> 'new#signup'
  get 'new/bustickets'=> 'new#bustickets'
  get 'new/cabs'=> 'new#cabs'
  get 'new/citybus'=> 'new#citybus'
  get 'new/flights'=> 'new#flights'
  get 'new/home'=> 'new#home'
  get 'new/metro'=> 'new#metro'
  get 'new/train'=> 'new#train'


end




 

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

