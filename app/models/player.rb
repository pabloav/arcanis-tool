class Player < ActiveRecord::Base
  def ready?
    master_clock = MasterClock.first
    if master_clock.clock >= clock
      return true
    end
    return false
  end
  
  def perform!(actclock, speed, add_strain=0, add_recovery=0)
    endtick = actclock + speed
    self.clock = endtick

    if add_strain > 0
      self.strain = self.strain + add_strain
      self.strain_clock = endtick
    end
    
    if add_recovery > 0 
      # In theory you can't do tricks through recovery, but don't want to enforce that here
      self.recovery = self.recovery + add_recovery 
      self.recovery_clock = endtick
    end
    
    self.save
  end

end
