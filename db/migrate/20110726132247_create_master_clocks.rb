class CreateMasterClocks < ActiveRecord::Migration
  def self.up
    create_table :master_clocks do |t|

      t.timestamps
      t.integer :clock, :default => 1
    end
  end

  def self.down
    drop_table :master_clocks
  end
end
