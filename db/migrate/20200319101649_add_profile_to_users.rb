# frozen_string_literal: true

class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :zipcode, :string, limit: 8
    add_column :users, :address, :string
    add_column :users, :profile, :string
  end
end
