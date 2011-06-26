class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.text :detail
      t.references :setting

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
