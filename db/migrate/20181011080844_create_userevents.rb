class CreateUserevents < ActiveRecord::Migration[5.2]
  def change
    create_table :userevents do |t|
      t.integer :userid
      t.integer :eventid

      t.timestamps
    end
  end
end
