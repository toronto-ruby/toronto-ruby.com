class AddSlugToEvent < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :slug, :string, null: false, as: %(lower(regexp_replace(regexp_replace(name, '\s+', '-', 'g'), '[^a-zA-Z0-9\-]', '', 'g'))), stored: true

    add_index :events, :slug, unique: true
  end
end
