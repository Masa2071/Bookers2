class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # ログイン認証されていなければ、ログイン画面にリダイレクト
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(resource.id)
  end
  # アカウント登録後の遷移先
  def after_sign_up_path_for(resource)
    user_path(resource.id)
  end
  def after_sign_out_path_for(resource)
     new_user_session_path
  end

  protected
  # ログイン後の遷移先

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])

  end
end
