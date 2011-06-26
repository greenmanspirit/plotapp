class CreateVirtues < ActiveRecord::Migration
  def self.up
    create_table :virtues do |t|
      t.string :detail
      t.references :character

      t.timestamps
    end
  end

  def self.down
    drop_table :virtues
  end
end
