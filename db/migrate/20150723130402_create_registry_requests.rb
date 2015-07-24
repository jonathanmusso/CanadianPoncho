class CreateRegistryRequests < ActiveRecord::Migration
  def change
    create_table :registry_requests do |t|
      t.datetime :approved_at
      t.datetime :denied_at
      t.text :notes
      t.references :vehicle, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
