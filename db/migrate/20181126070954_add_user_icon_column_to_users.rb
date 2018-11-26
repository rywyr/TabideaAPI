class AddUserIconColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :icon_image, :string, after: :name
  end
end
