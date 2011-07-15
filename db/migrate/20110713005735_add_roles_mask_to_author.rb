class AddRolesMaskToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :roles_mask, :integer
  end

  def self.down
    remove_column :authors, :roles_mask
  end
end
