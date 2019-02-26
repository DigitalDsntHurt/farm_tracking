class System < ApplicationRecord
  belongs_to :room

  before_save :set_retired
  
  private

  def set_retired
  	self.retired = true if self.retired_on != nil
  end
end
