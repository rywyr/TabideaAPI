class CreateEventcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :eventcategories do |t|
      t.integer :event_id
      t.integer :category_id
      t.timestamps
    end
  end
end
