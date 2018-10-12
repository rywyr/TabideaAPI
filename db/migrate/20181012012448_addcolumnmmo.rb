class Addcolumnmmo < ActiveRecord::Migration[5.2]
  def change
     add_column :mmos, :viewIndex, :integer
  end
end
