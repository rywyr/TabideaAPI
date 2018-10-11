class RenameTitreColumnTo < ActiveRecord::Migration[5.2]
  def change
      rename_column :userevents, :userid, :user_id
      rename_column :userevents, :eventid, :event_id
  end
end
