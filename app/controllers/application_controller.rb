# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_clock

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
private
  def set_clock
    @master_clock = MasterClock.first
    if @master_clock.nil?
      m = MasterClock.new()
      m.clock = 1
      m.save
    end
  end
end
