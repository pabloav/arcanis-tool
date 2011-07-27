# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def timestamp
    return "<span class=\"timestamp\">(#{Time.now().strftime("%I:%M:%S%P").downcase})</span>"
  end
  
  def set_action_speed(name, speed)
    link_to_function(name, "set_value('action_speed', #{speed}); RedBox.close();")
  end
end
