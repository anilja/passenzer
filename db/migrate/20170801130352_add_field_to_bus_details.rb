class AddFieldToBusDetails < ActiveRecord::Migration[5.0]
  def change
    add_column :bus_details, :is_main, :boolean, default: false
    add_column :bus_details, :source_first, :string
    add_column :bus_details, :source_last, :string
    add_column :bus_details, :destination_first, :string
    add_column :bus_details, :destination_last, :string
    add_column :bus_details, :is_return_route, :boolean, default: true
  end
end
