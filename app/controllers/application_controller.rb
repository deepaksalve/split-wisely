class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
  end

  def about
  end

  def contact
  end

  private

  def require_login
    unless current_user
      redirect_to new_user_session_url
    end
  end
end
