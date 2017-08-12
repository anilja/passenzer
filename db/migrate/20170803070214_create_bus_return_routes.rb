class CreateBusReturnRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :bus_return_routes do |t|
      t.string :name
      t.float :source_distance
      t.float :destination_distance
      t.integer :bus_detail_id
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
