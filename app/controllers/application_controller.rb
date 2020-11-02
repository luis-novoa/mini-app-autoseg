class ApplicationController < ActionController::Base
  before_action :check_user
  skip_before_action :check_user, if: :devise_controller?

  private

  def check_user
    redirect_to new_user_session_path unless current_user
  end
end
