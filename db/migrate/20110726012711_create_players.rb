class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|

      t.timestamps
      t.string :name
      t.integer :clock, :default => 1
      t.integer :recovery, :default => 0
      t.integer :recovery_clock, :default => 0
      t.integer :strain, :default => 0
      t.integer :strain_clock, :default => 0
      t.boolean :npc, :default => false
    end
  end

  def self.down
    drop_table :players
  end
end
