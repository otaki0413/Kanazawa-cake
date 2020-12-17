class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all.order(created_at: :desc) #新しい順に並び替える
  end


  def show
    @order = Order.find(params[:id])
    # 特定の注文idに紐づく注文商品のデータ全て
    @ordered_items = @order.order_details

    # 商品の合計金額
    @total_payment = 0
    @ordered_items.each do |order_item|
      @total_payment += order_item.subtotal.to_i
    end

    # 請求金額
    @freight_total_payment = @total_payment + @order.freight
  end


  # 注文ステータス更新
  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details

    # if文を使って、ステータスを条件分岐
    # 共通の注文idを持つ、注文商品全ての製作ステータスを更新したい
    # 複数のレコードの同一カラムを更新したい→update_allを使う！
    if @order.status == "入金確認"
      @order_details.update_all(making_status: "製作待ち")
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end

  end


  private
  def order_params
    params.require(:order).permit(:status)
  end
end
