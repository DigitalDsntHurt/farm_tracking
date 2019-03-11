Rails.application.routes.draw do
  
  resources :scheduleds
  
  resources :orders
  resources :nutrient_solutions
  resources :reservoirs
  
  resources :rooms
  resources :systems

	get 'dashboards/calendar'
	get 'dashboards/sew_calendar'
	get 'dashboards/soak_sew_cal'
	get 'dashboards/ops_calendar'
	get 'dashboards/pipeline'
	get 'dashboards/page_pipeline'
	get 'dashboards/warehouse_pipeline'
	get 'dashboards/old_pipeline'
	get 'dashboards/calculator'
	get 'dashboards/calculate'
	get 'dashboards/cutsheet'
	get 'dashboards/back_of_envelope'
	get 'dashboards/aggregates'
	get 'dashboards/crop_availability'
	get 'dashboards/crop_menu'
	get 'dashboards/scratch'
	get 'dashboards/flat_allocation'

	get 'seed_flats/live_index' => 'seed_flats#live_index'
	get 'seed_flats/harvested_index' => 'seed_flats#harvested_index'
	get 'seed_flats/killed_index' => 'seed_flats#killed_index'
	get 'seed_flats/harvested_killed' => 'seed_flats#harvested_killed'
	get 'seed_flats/copy' => 'seed_flats#copy'
	get 'seed_flats/copy_treated_seed_flat' => 'seed_flats#copy_treated_seed_flat'
	get 'seed_flats/first_emerge' => 'seed_flats#first_emerge'
	get 'seed_flats/full_emerge' => 'seed_flats#full_emerge'
	get 'seed_flats/cascade_full_emerge' => 'seed_flats#cascade_full_emerge'
	get 'seed_flats/first_transplant' => 'seed_flats#first_transplant'
	get 'seed_flats/second_transplant' => 'seed_flats#second_transplant'
	get 'seed_flats/third_transplant' => 'seed_flats#third_transplant'
	get 'seed_flats/harvest' => 'seed_flats#harvest'
	get 'seed_flats/kill' => 'seed_flats#kill'
	get 'seed_flats/new_treated_seed_flat' => 'seed_flats#new_treated_seed_flat'
	resources :seed_flats

	get 'seed_flat_updates/transplant' => 'seed_flat_updates#transplant'
	get 'seed_flat_updates/transplant_to_raquel' => 'seed_flat_updates#transplant_to_raquel'
	get 'seed_flat_updates/transplant_to_sue' => 'seed_flat_updates#transplant_to_sue'
	get 'seed_flat_updates/transplant_to_klay' => 'seed_flat_updates#transplant_to_klay'
	get 'seed_flat_updates/transplant_to_naga' => 'seed_flat_updates#transplant_to_naga'
	get 'seed_flat_updates/transplant_to_rezha' => 'seed_flat_updates#transplant_to_rezha'
	get 'seed_flat_updates/transplant_to_meow' => 'seed_flat_updates#transplant_to_meow'
	get 'seed_flat_updates/transplant_to_littlefoot' => 'seed_flat_updates#transplant_to_littlefoot'
	get 'seed_flat_updates/transplant_to_dumbo' => 'seed_flat_updates#transplant_to_dumbo'
	get 'seed_flat_updates/transplant_to_livestorage' => 'seed_flat_updates#transplant_to_livestorage'
	get 'seed_flat_updates/transplant_to_gar' => 'seed_flat_updates#transplant_to_gar'
	get 'seed_flat_updates/transplant_to_lev' => 'seed_flat_updates#transplant_to_lev'
	get 'seed_flat_updates/transplant_to_pip' => 'seed_flat_updates#transplant_to_pip'
	get 'seed_flat_updates/transplant_to_jez' => 'seed_flat_updates#transplant_to_jez'
	resources :seed_flat_updates
	
	get 'seed_treatments/fresh_index'
	get 'seed_treatments/clone' => 'seed_treatments#clone'
	get 'seed_treatments/end_soak' => 'seed_treatments#end_soak'
	get 'seed_treatments/first_emerge' => 'seed_treatments#first_emerge'
	get 'seed_treatments/full_emerge' => 'seed_treatments#full_emerge'
	get 'seed_treatments/finish' => 'seed_treatments#finish'
	get 'seed_treatments/kill' => 'seed_treatments#kill'
	resources :seed_treatments

	get 'crops/crop_ref' => 'crops#crop_ref'
	resources :crops

	get 'farm_ops_dos/mark_farm_ops_dos_done' => 'farm_ops_dos#mark_farm_ops_dos_done'
	resources :farm_ops_dos
	
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'dashboards#pipeline'
end
