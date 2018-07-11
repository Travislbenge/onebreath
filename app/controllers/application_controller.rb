# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!


def default_url_options
  { host: ENV["HOST"] || "http://www.takeonebreath.com" }
end

end

