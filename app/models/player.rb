class Player < ActiveRecord::Base
  def ready?(master_clock)
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
  
  def push!(master_clock, speed)
    self.clock = max(self.clock, master_clock.clock) + speed
    if self.strain > 0
      self.strain_clock = max(self.strain_clock, master_clock.clock) + speed
    end
    if self.recovery > 0
      self.recovery_clock = max(self.recovery_clock, master_clock.clock) + speed
    end
    self.save
  end
  
  def strain_label
    str = "#{self.strain}"
    if self.strain > 0
      str += " (#{self.strain_clock})"
    end
    return str
  end

  def recovery_label
    str = "#{self.recovery}"
    if self.recovery > 0
      str += " (#{self.recovery_clock})"
    end
    return str
  end

private
  def max(a, b)
    if a > b
      return a
    end
    return b
  end

end
