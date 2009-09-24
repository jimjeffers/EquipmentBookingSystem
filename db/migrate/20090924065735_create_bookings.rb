class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.references :user
      t.references :instance
      t.string :aasm_state
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
