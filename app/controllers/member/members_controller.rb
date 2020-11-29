class Member::MembersController < ApplicationController
  before_action :authenticate_member!

  # マイページ
  def index
  end

  def edit
    @member = current_member
  end

  def update
    @member = current_member
    @member.update(member_params)
    flash[:notice] = "Your profile have updated successfully."
    redirect_to member_path
  end

  def unsubscribe
  end

  def retire
    member = current_member
    # カラム名が1つの時に使う、update_attributes
    member.update_attributes(is_deleted: true)
    flash[:notice] = "Your have retired successfully."
    reset_session
    redirect_to root_path
  end

  # ストロングパラメータ
  private
  def member_params
    params.require(:member).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number)
  end
end
