class AddStoryToCharacter < ActiveRecord::Migration
  def self.up
    add_column :characters, :story_id, :integer
  end

  def self.down
    remove_column :characters, :story_id
  end
end
