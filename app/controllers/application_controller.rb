class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  respond_to :json #so that app always responds to json
  protect_from_forgery with: :null_session #API style controller, no use for session object.
  skip_before_action :verify_authenticity_token #So we can skip authectication token from rails.
end
