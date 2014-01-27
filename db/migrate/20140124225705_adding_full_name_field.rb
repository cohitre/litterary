class AddingFullNameField < ActiveRecord::Migration
  def up
    add_column :users, :full_name, :string
    remove_column :users, :name
    remove_column :users, :lastname
  end

  def down
    remove_column :users, :full_name
    add_column :users, :name, :string
    add_column :users, :lastname, :string
  end
end
