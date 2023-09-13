class AddUserApprovedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :user_approved, :boolean, default: false
  end
end
