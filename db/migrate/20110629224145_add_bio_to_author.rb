class AddBioToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :bio, :text
  end

  def self.down
    remove_column :authors, :bio
  end
end
