module ApplicationHelper
  #helpers is where we put presentation level logic used in view templates
  #Rails helpers allow us to consolidate our application's 
  #logic and formatting so we can properly display information
  #in the views. By declaring helper methods within the 
  #{}"application_helper.rb" file, we are able to use the methods in the 
  #views without convoluting the views with logic code.

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(date_time)
    date_time.strftime("%m/%d/%Y %l:%M%P %Z") #mm/dd/yyy hr:min pm
  end
end
