class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.string :password_digest, limit: 191,  null: false
      t.string :remember_token,  limit: 191,  
      t.timestamps
    end
  end
end
