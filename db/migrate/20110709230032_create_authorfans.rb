class CreateAuthorfans < ActiveRecord::Migration
  def self.up
    create_table :authorfans do |t|
      t.integer :author_id
      t.integer :fan_id

      t.timestamps
    end
  end

  def self.down
    drop_table :authorfans
  end
end
