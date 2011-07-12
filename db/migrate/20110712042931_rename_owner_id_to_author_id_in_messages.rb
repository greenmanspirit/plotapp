class RenameOwnerIdToAuthorIdInMessages < ActiveRecord::Migration
  def self.up
  	rename_column :messages, :owner_id, :author_id
  end

  def self.down
  	rename_column :messages, :author_id, :ownder_id
  end
end
