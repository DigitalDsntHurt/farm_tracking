	Rails.application.routes.draw do
	  
  get 'dashboards/calendar'

  get 'dashboards/pipeline'

  get 'dashboards/calculator'

	  get 'seed_flats/copy' => 'seed_flats#copy'
	  get 'seed_flats/first_emerge' => 'seed_flats#first_emerge'
	  get 'seed_flats/full_emerge' => 'seed_flats#full_emerge'
	  get 'seed_flats/first_transplant' => 'seed_flats#first_transplant'
	  get 'seed_flats/second_transplant' => 'seed_flats#second_transplant'

	  resources :seed_flats

	  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	  root 'seed_flats#index'
	  #get 'duplicate_seed_flat' => 'seed_flats#new'
	end
