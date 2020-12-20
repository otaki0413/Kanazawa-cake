class Member::DeliveryGoalsController < ApplicationController
  before_action :authenticate_member!

  def index
    @new_delivery = DeliveryGoal.new
    @member = current_member
    @deliverys = @member.delivery_goals
  end

  def create
    @new_delivery = DeliveryGoal.new(delivery_params)
    @new_delivery.member_id = current_member.id
    @new_delivery.save
    flash[:notice] = "新しく配送先を登録しました！"
    redirect_to delivery_goals_path
  end

  def edit
    @delivery = DeliveryGoal.find(params[:id])
  end

  def update
    @delivery = DeliveryGoal.find(params[:id])
    @delivery.update(delivery_params)
    flash[:notice] = "配送先を更新しました！"
    redirect_to delivery_goals_path
  end

  def destroy
    delivery = DeliveryGoal.find(params[:id])
    delivery.destroy
    redirect_to delivery_goals_path
  end

   # ストロングパラメータ
  private
  def delivery_params
    params.require(:delivery_goal).permit(:member_id, :postcode, :address, :name)
  end
end
