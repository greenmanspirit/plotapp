class AddOwnerToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :owner_id, :integer
  end

  def self.down
    remove_column :messages, :owner_id
  end
end
