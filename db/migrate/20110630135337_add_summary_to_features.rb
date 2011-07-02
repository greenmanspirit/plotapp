class AddSummaryToFeatures < ActiveRecord::Migration
  def self.up
    add_column :features, :summary, :string
  end

  def self.down
    remove_column :features, :summary
  end
end
