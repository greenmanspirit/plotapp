class CreateVices < ActiveRecord::Migration
  def self.up
    create_table :vices do |t|
      t.string :detail
      t.references :character

      t.timestamps
    end
  end

  def self.down
    drop_table :vices
  end
end
