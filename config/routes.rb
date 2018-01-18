Rails.application.routes.draw do
  
  get 'seed_flats/copy' => 'seed_flats#copy'
  resources :seed_flats

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'seed_flats#index'
  #get 'duplicate_seed_flat' => 'seed_flats#new'
end
