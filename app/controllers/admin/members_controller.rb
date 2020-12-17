class Admin::MembersController < ApplicationController
  before_action :this_member, only: [:show, :edit, :update]
  before_action :authenticate_admin!

  def index
    @members = Member.all
  end

  def show
    # @member = Member.find(params[:id])
  end

  def edit
    # @member = Member.find(params[:id])
  end

  # 会員データ更新
  def update
    # @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "You have updated member's profile successfully."
      redirect_to admin_member_path(@member)
    else
      render :edit
    end
  end

  private
  def this_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :is_deleted)
  end
end
