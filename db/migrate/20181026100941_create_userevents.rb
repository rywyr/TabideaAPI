class CreateUserevents < ActiveRecord::Migration[5.2]
  def change
    create_table :userevents do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end
end
