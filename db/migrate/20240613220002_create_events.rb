class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :rsvp_link
      t.text :location
      t.text :presentation
      t.text :presenter
      t.string :sponsor
      t.string :sponsor_link
      t.string :sponsor_logo
      t.integer :status
      t.timestamp :start_at

      t.timestamps
    end
  end
end
