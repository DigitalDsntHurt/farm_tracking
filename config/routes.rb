Rails.application.routes.draw do
  
  	resources :rooms
  	resources :systems

	get 'dashboards/calendar'
	get 'dashboards/sew_calendar'
	get 'dashboards/pipeline'
	get 'dashboards/pipeline_draft'
	get 'dashboards/calculator'
	get 'dashboards/calculate'
	get 'dashboards/cutsheet'
	get 'dashboards/back_of_envelope'
	get 'dashboards/crop_menu'
	get 'dashboards/scratch'

	get 'seed_flats/live_index' => 'seed_flats#live_index'
	get 'seed_flats/harvested_killed' => 'seed_flats#harvested_killed'
	get 'seed_flats/copy' => 'seed_flats#copy'
	get 'seed_flats/first_emerge' => 'seed_flats#first_emerge'
	get 'seed_flats/full_emerge' => 'seed_flats#full_emerge'
	get 'seed_flats/first_transplant' => 'seed_flats#first_transplant'
	get 'seed_flats/second_transplant' => 'seed_flats#second_transplant'
	get 'seed_flats/third_transplant' => 'seed_flats#third_transplant'
	get 'seed_flats/harvest' => 'seed_flats#harvest'
	get 'seed_flats/kill' => 'seed_flats#kill'
	get 'seed_flats/new_treated_seed_flat' => 'seed_flats#new_treated_seed_flat'
	resources :seed_flats

	get 'seed_flat_updates/transplant' => 'seed_flat_updates#transplant'
	resources :seed_flat_updates
	
	get 'seed_treatments/clone' => 'seed_treatments#clone'
	get 'seed_treatments/end_soak' => 'seed_treatments#end_soak'
	get 'seed_treatments/first_emerge' => 'seed_treatments#first_emerge'
	get 'seed_treatments/full_emerge' => 'seed_treatments#full_emerge'
	get 'seed_treatments/finish' => 'seed_treatments#finish'
	get 'seed_treatments/kill' => 'seed_treatments#kill'
	resources :seed_treatments
	
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'dashboards#pipeline'
end
