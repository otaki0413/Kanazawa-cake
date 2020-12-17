class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # def after_sign_in_path_for(resource)
  #   if current_admin
  #     flash[:notice] = "Signed in successfully."
  #     admin_top_path #指定したいパスに変更
  #   end

  #   if current_member
  #     flash[:notice] = "Signed in successfully."
  #     products_path #指定したいパスに変更
  #   end
  # end

  # def after_sign_up_path_for(resource)

  #   if current_member
  #     flash[:notice] = "Signed up successfully."
  #     products_path
  #   end
  # end


  # def after_sign_out_path_for(resource)

  #   if resource == :admin
  #     binding.pry
  #     # flash[:notice] = "Signed out successfully"
  #     new_admin_session_path
  #   end

  #   if resource == :member
  #     # flash[:notice] = "Signed out successfully"
  #     root_path
  #   end
  # end

  protected
  # サインアップ時に任意のカラムを入力必須にする
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number])
  end
end
