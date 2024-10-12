class MigrateEventContentToActionText < ActiveRecord::Migration[7.1]
  include ActionView::Helpers::TextHelper

  def up
    rename_column :events, :location, :location_plain
    Event.find_each do |event|
      event.update_attribute(:location, simple_format(event.location_plain))
      event.update_attribute(:description, "#{event.presentation} by #{event.presenter}")
    end
    remove_column :events, :location_plain
    remove_column :events, :presenter
    remove_column :events, :presentation
  end

  def down
    puts 'WARNING, YOU MUST MANUALLY UPDATE INFORMATION THAT IS PRINTED BELOW.'
    add_column :events, :location_plain, :text
    add_column :events, :presenter, :text
    add_column :events, :presentation, :text
    Event.find_each do |event|
      event.update_attribute(:location_plain, event.location.body.to_plain_text)
      puts "Event #{event.id} Description"
      puts event.description.body.to_plain_text
    end
    rename_column :events, :location_plain, :location
  end
end
