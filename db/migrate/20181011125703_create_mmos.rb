class CreateMmos < ActiveRecord::Migration[5.2]
  def change
    create_table :mmos do |t|
      t.string :text
      t.integer :xposition, null: false
      t.integer :yposition, null: false
      t.integer :parent
      t.references :event, foreign_key: true
      t.integer :viewIndex

      t.timestamps
    end
  end
end
