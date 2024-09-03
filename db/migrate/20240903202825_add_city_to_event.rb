class AddCityToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :city, :string, null: false, default: "Toronto, Canada"
  end
end
