class Addcolumnevents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :eventname, :string

    add_column :events, :explain, :string

  end
end
