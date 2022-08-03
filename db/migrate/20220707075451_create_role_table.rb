class CreateRoleTable < ActiveRecord::Migration[7.0]
  def change
    create_table :role_tables do |t|

      t.timestamps
    end
  end
end
