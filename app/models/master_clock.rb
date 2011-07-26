class MasterClock < ActiveRecord::Base

  def tick!
    self.increment!(:clock)
    # Go through the players, check if their strain/recovery needs to be reduced
    Player.all.each do |p|
      # Decrement strain
      if p.strain > 0 and self.clock > p.strain_clock
        p.decrement!(:strain)
      end
      
      # Decrement recovery
      if p.recovery > 0 and self.clock > p.recovery_clock
        p.decrement!(:recovery)
      end
    end
  end
  
  def touch!
    self.increment!(:serial)
  end
  
  def reset!
    self.clock = 1
    self.serial = 1
    self.save
  end

end
