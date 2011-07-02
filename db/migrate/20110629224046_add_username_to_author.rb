class AddUsernameToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :username, :string
  end

  def self.down
    remove_column :authors, :username
  end
end
