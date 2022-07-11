class UserTableChange < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :password_confirmation, :address
    add_column :users, :role_id, :integer
    add_column :users, :licenses, :string
  end
end
