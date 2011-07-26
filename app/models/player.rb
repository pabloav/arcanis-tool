class Player < ActiveRecord::Base
  def ready?
    master_clock = MasterClock.first
    if master_clock.clock >= clock
      return true
    end
    return false
  end
end
