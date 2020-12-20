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
    if @member.update(member_params)
      flash[:notice] = "会員情報を更新しました！"
      redirect_to member_path
    else
      render edit
    end
  end

  # 退会確認ページ
  def unsubscribe
  end

  def retire
    member = current_member
    真偽値反転
    member.toggle!(:is_deleted)
    # どちらでもいいが、今回は下のupdate_attributesでいく
    # カラム名が1つの時に使う
    member.update_attributes(is_deleted: true)
    reset_session # すべてのセッション情報を削除
    flash[:notice] = "ありがとうございました！またのご利用をお待ちしています！"
    redirect_to root_path
  end

  # ストロングパラメータ
  private
  def member_params
    params.require(:member).permit(:email, :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :is_deleted)
  end
end
