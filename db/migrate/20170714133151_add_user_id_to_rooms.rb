class AddUserIdToRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :user_id, :interger 
  end
end
