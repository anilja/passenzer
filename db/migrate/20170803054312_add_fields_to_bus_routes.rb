class AddFieldsToBusRoutes < ActiveRecord::Migration[5.0]
  def change
    add_column :bus_routes, :first_name, :string
    add_column :bus_routes, :last_name, :string
  end
end
