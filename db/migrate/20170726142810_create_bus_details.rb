class CreateBusDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_details do |t|
      t.string :name
      t.string :number
      t.string :source
      t.string :destination
      t.float :source_lat
      t.float :destination_lat
      t.float :source_lang
      t.float :destination_lang

      t.timestamps
    end
  end
end
