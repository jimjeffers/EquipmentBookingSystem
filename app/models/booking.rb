class Booking < ActiveRecord::Base
  # Relationships
  belongs_to :user
  belongs_to :instance
end
