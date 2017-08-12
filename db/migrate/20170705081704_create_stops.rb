class CreateStops < ActiveRecord::Migration[5.0]
  def change
    create_table :stops do |t|
      t.string :content
      t.references :busform, foreign_key: true

      t.timestamps
    end
  end
end
