class CreateEventcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :eventcategories do |t|
      t.references :event, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.timestamps
    end
  end
end
