class AddLatestPostDateToTopic < ActiveRecord::Migration
  def self.up
    add_column :topics, :last_post_date, :datetime
  end

  def self.down
    remove_column :topics, :last_post_date
  end
end
