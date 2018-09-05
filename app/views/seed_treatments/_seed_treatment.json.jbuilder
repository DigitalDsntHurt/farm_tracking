json.extract! seed_treatment, :id, :soak_start_datetime, :seed_crop, :seed_variety, :seed_brand, :seed_quantity_oz, :soak_solution, :soak_duration_hrs, :post_soak_treatment, :soak_notes, :germination_start_date, :germination_vehicle, :first_emerge_date, :full_emerge_date, :days_to_full_emergence, :emergence_notes, :killed_on, :planned_date_of_first_flat_sew, :date_of_first_flat_sew, :date_of_last_flat_sew, :destination_flat_ids, :created_at, :updated_at
json.url seed_treatment_url(seed_treatment, format: :json)