class CreateCharacters < ActiveRecord::Migration
  def self.up
    create_table :characters do |t|
      t.string :name
      t.string :birthdate
      t.integer :age
      t.string :hometown
      t.string :parents
      t.text :other

      t.timestamps
    end
  end

  def self.down
    drop_table :characters
  end
end
