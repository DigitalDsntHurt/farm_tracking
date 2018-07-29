class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  http_basic_authenticate_with :name => ENV["NAME"], :password => ENV["PASSWORD"]

=begin
  before_action :verify_ip_address

  private

  def verify_ip_address
  	# head :unauthorized if Whitelist.find_by(ip_address: request.remote_ip).nil?
  	if Whitelist.find_by(ip_address: request.remote_ip).nil?
  		#redirect_to "https://www.dictionary.com/e/wp-content/uploads/2018/06/middle-finger.jpg"
  		redirect_to root_path
  	end
  end

=end  
=begin
  before_action :block_foreign_hosts

  def whitelisted?(ip)
  	return true if ["76.126.142.157"].include?(ip.to_s)
  	false
  end

  def block_foreign_hosts
  	return false if whitelisted?(request.remote_ip)
  	redirect_to "https://www.dictionary.com/e/wp-content/uploads/2018/06/middle-finger.jpg" unless request.remote_ip == "76.126.142.157"
  end
=end

end
