class CreatePlotpoints < ActiveRecord::Migration
  def self.up
    create_table :plotpoints do |t|
      t.string :summary
      t.text :details
      t.references :story

      t.timestamps
    end
  end

  def self.down
    drop_table :plotpoints
  end
end
