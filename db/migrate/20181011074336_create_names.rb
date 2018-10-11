class CreateNames < ActiveRecord::Migration[5.2]
  def change
    create_table :names do |t|
      t.string :event
      t.string :eventname
      t.string :explain

      t.timestamps
    end
  end
end
