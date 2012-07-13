class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :put_separator
  def put_separator
    puts "\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n"
    puts " params ===> #{params.inspect unless params.nil?}\n\n"
    puts " current_user ===> #{current_refinery_user.inspect unless current_refinery_user.nil?}\n\n"    
    #puts " current_user_role ===> #{current_refinery_user[:role_id].inspect unless current_refinery_user.nil?}\n\n"
  end   
  
  def log_it(text)
    Rails.logger.debug "\n\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\nlog_it ==> #{text.inspect}\n%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n"
  end
  
end