class AddAuthorToStory < ActiveRecord::Migration
  def self.up
    add_column :stories, :author_id, :integer
  end

  def self.down
    remove_column :stories, :author_id
  end
end
