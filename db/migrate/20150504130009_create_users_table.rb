class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token, unique: :true

      t.timestamps null: false
    end
  end
end
