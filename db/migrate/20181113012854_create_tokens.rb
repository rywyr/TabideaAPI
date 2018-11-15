class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.references :user, null: false
      t.integer :event_id, null:false
      t.string :uuid
      t.datetime :expire_at

      t.timestamps
    end
  end
end
