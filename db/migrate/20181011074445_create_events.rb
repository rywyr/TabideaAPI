class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :eventname, null: false
      t.string :eventpass, null: false

      t.timestamps
    end
  end
end
