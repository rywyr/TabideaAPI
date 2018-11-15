class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :creator
      t.timestamps
    end
  end
end
