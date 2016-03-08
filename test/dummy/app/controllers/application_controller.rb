class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def peek_enabled?
    if defined?(@peek_enabled)
      !!@peek_enabled
    else
      true
    end
  end
end
