class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == APP_CONFIG[:http_username]  && password == APP_CONFIG[:http_password]
    end
  end

end
