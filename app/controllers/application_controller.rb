class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    if current_admin
      flash[:notice] = "Signed in successfully."
      admin_path #指定したいパスに変更
    end
  end

end
