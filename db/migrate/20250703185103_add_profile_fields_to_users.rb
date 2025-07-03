class AddProfileFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :zipcode, :string
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
    add_column :users, :date_of_birth, :date
  end
end
