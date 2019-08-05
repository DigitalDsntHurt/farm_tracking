Rails.application.routes.draw do
  
  
  resources :crop_mixes
  resources :over_grow_recipients
  get 'lists/harvest'

  resources :weekly_revenues
  resources :media_unit_costs
  resources :team_members_shifts
  resources :team_members
  get 'daily_priorities/n_form' => 'daily_priorities#n_form'
  get 'daily_priorities/d_form' => 'daily_priorities#d_form'
  get 'daily_priorities/weekly_dash' => 'daily_priorities#weekly_dash'
  resources :daily_priorities

  get 'calendars/ops'
  get 'calendars/harvest'
  get 'calendars/sew'
  get 'calendars/soak'

  resources :customers
  resources :scheduleds
  
  get 'orders/clone' => 'orders#clone'
  get 'orders/cancel' => 'orders#cancel'
  get 'orders/current_index' => 'orders#current_index'
  get 'orders/orders_calendar' => 'orders#orders_calendar'
  get 'orders/new_standing_order_form' => 'orders#new_standing_order_form'
  get 'orders/new_ad_hoc_order_form' => 'orders#new_ad_hoc_order_form'
  resources :orders

  resources :nutrient_solutions

  resources :reservoirs
  
  resources :rooms
  resources :systems

	get 'dashboards/crop_availability'
	get 'dashboards/aggregates'
	get 'dashboards/averages'
	get 'dashboards/yield_per_dth'
	get 'dashboards/yield_per_seed_weight'
	get 'dashboards/calendar'
	get 'dashboards/sew_calendar'
	get 'dashboards/soak_sew_cal'
	get 'dashboards/ops_calendar'
	get 'dashboards/transplant_calendar'
	get 'dashboards/harvest_calendar'
	get 'dashboards/pipeline'
	get 'dashboards/page_pipeline'
	get 'dashboards/warehouse_pipeline'
	get 'dashboards/old_pipeline'
	get 'dashboards/calculator'
	get 'dashboards/calculate'
	get 'dashboards/cutsheet'
	get 'dashboards/back_of_envelope'
	get 'dashboards/crop_menu'
	get 'dashboards/scratch'
	get 'dashboards/flat_allocation'
	get 'dashboards/labels'
	get 'dashboards/customers'
	get 'dashboards/add_customer'
	get 'dashboards/finance'
	get 'dashboards/flats_per_week'
	get 'dashboards/weekly_seed_use'
	get 'dashboards/customer_harvest_history'
	get 'dashboards/bulk_form' => 'dashboards#bulk_form'
	post 'dashboards/bulk_form' => 'dashboards#bulk_form'
	get 'dashboards/bulk_form_conf' => 'dashboards#bulk_form_conf'
	get 'dashboards/crop_alphabetization' => 'dashboards#crop_alphabetization'
	get 'dashboards/pull_todays_flats_for_harvest' => 'dashboards#pull_todays_flats_for_harvest'

	get 'seed_flats/live_index' => 'seed_flats#live_index'
	get 'seed_flats/basic_index' => 'seed_flats#basic_index'
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
	get 'seed_flats/new_treated_seed_flat_from_ops_cal' => 'seed_flats#new_treated_seed_flat_from_ops_cal'
	get 'seed_flats/new_prepopulated' => 'seed_flats/new_prepopulated'
	resources :seed_flats do 
		collection do
			put :bulk_actions
		end
	end

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
	get 'seed_flat_updates/transplant_to_dil' => 'seed_flat_updates#transplant_to_dil'
	get 'seed_flat_updates/transplant_to_mia' => 'seed_flat_updates#transplant_to_mia'
	get 'seed_flat_updates/transplant_to_bam' => 'seed_flat_updates#transplant_to_bam'
	get 'seed_flat_updates/transplant_to_lip' => 'seed_flat_updates#transplant_to_lip'
	get 'seed_flat_updates/transplant_flat' => 'seed_flat_updates#transplant_flat'
	get 'seed_flat_updates/harvest' => 'seed_flat_updates#harvest'
	get 'seed_flat_updates/full_index' => 'seed_flat_updates#full_index'
	resources :seed_flat_updates
	
	get 'seed_treatments/fresh_index'
	get 'seed_treatments/clone' => 'seed_treatments#clone'
	get 'seed_treatments/end_soak' => 'seed_treatments#end_soak'
	get 'seed_treatments/first_emerge' => 'seed_treatments#first_emerge'
	get 'seed_treatments/full_emerge' => 'seed_treatments#full_emerge'
	get 'seed_treatments/finish' => 'seed_treatments#finish'
	get 'seed_treatments/kill' => 'seed_treatments#kill'
	get 'seed_treatments/new_assigned_seed_treatment' => 'seed_treatments#new_assigned_seed_treatment'
	get 'seed_treatments/cascade_full_emerge' => 'seed_treatments#cascade_full_emerge'
	get 'seed_treatments/bulk_soak_form' => 'seed_treatments#bulk_soak_form'
	resources :seed_treatments

	get 'crops/crop_ref' => 'crops#crop_ref'
	get 'crops/clone' => 'crops#clone'
	resources :crops

	get 'farm_ops_dos/mark_farm_ops_dos_done' => 'farm_ops_dos#mark_farm_ops_dos_done'
	get 'farm_ops_dos/mark_farm_ops_dos_undone' => 'farm_ops_dos#mark_farm_ops_dos_undone'
	resources :farm_ops_dos do
		collection do
			put :bulk_actions
		end
	end
	
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'dashboards#pipeline'
end
