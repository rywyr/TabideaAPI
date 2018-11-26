class AddEventIconColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :icon_image, :string, after: :title
  end
end
