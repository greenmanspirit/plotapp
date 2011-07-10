class CreateStoryfans < ActiveRecord::Migration
  def self.up
    create_table :storyfans do |t|
      t.integer :author_id
      t.integer :story_id

      t.timestamps
    end
  end

  def self.down
    drop_table :storyfans
  end
end
