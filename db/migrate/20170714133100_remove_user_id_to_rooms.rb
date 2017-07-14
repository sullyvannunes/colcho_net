class RemoveUserIdToRooms < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_id
  end
end
