class CreateTopictracks < ActiveRecord::Migration
  def self.up
    create_table :topictracks do |t|
      t.integer :author_id
      t.integer :topic_id
      t.datetime :last_time_viewed

      t.timestamps
    end
  end

  def self.down
    drop_table :topictracks
  end
end
