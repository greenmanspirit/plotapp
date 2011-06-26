class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.text :detail
      t.references :setting

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
