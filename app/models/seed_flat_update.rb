class SeedFlatUpdate < ApplicationRecord
  belongs_to :seed_flat
  

  validates :customer_id, presence: true, if: -> {update_type == "harvest" }
  validates :harvest_qty_oz, presence: true, if: -> {update_type == "harvest" }
  validates :customer_id, presence: true, if: -> {update_type == "delivered as live flat" }

  after_create :set_seed_flat_current_system_id, :update_seed_flat_harvest, :set_update_date
  after_update :set_seed_flat_current_system_id, :update_seed_flat_harvest, :set_update_date

  private

  def set_seed_flat_current_system_id
  	unless self.destination_system_id == nil
	  	seed_flat = self.seed_flat
  		seed_flat.update(current_system_id: self.destination_system_id)
  	end
  end

  def update_seed_flat_harvest
    if self.finished == true
      #@seed_flat = SeedFlat.where(id: self.seed_flat_id)
      @all_harvests = SeedFlatUpdate.where(seed_flat_id: self.seed_flat_id).where(update_type: "harvest")
      if @all_harvests.count > 0
        @total_harvest_weight = @all_harvests.map{|harvest| harvest.harvest_qty_oz}.inject{|sum,weight| sum + weight }
        SeedFlat.where(id: self.seed_flat_id).update(harvest_weight_oz: @total_harvest_weight )
      else
        @total_harvest_weight = self.harvest_qty_oz
        SeedFlat.where(id: self.seed_flat_id).update(harvest_weight_oz: @total_harvest_weight )
      end
    end
  end

  def set_update_date
    self.update_date = updated_at.to_date
  end
  
  #def ensure_customer_id
  #  if self.customer_id == nil
  #    self.customer_id = 1
  #  end
  #end

end
