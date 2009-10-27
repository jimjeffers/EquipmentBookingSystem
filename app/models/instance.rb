class Instance < ActiveRecord::Base
  # Relationships
  has_many :bookings
  belongs_to :item
  
  # Validations
end
