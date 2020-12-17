class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  # 製作ステータス更新
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    @order =  @order_detail.order

    if @order_detail.making_status == "製作中"
      @order.update(status: "製作中")
      redirect_back(fallback_location: root_path)
    elsif @order_detail.making_status == "製作完了"
      @order.update(status: "発送準備中")
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
