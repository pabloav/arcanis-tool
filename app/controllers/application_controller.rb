# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_clock
  
  def current_clock
    render :text => @master_clock.clock
  end
  
  def current_serial
    render :text => @master_clock.serial
  end
  
  def current
    render :json => { :clock => @master_clock.clock, :serial => @master_clock.serial }.to_json
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
private
  def set_clock
    @master_clock = MasterClock.first
    if @master_clock.nil?
      m = MasterClock.new()
      m.clock = 1
      m.save
      @master_clock = m
    end
  end
end
