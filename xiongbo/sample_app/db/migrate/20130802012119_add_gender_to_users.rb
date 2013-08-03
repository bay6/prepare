class AddGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :boolean, default: true
  end
end
