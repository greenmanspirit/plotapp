class AddPositionToPlotpoints < ActiveRecord::Migration
  def self.up
    add_column :plotpoints, :position, :integer
  end

  def self.down
    remove_column :plotpoints, :position
  end
end
