class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :model
      t.integer :year
      t.string :production_date
      t.string :engine
      t.string :transmission
      t.string :trim
      t.string :color
      t.string :options
      t.string :location
      t.text :description

      t.timestamps null: false
    end
  end
end
