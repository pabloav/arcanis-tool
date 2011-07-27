# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def timestamp
    return "<span class=\"timestamp\">(#{Time.now().strftime("%I:%M:%S%P").downcase})</span>"
  end
end
