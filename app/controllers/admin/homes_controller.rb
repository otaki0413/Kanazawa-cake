class Admin::HomesController < ApplicationController

  # ここがよくわからん

  # 本日の注文件数
  def top
    @orders = Order.all
  	if @orders.where([:created_at].to_s.match(/#{Date.today.to_s}.+/)).present?
  		@order_data = @orders.where([:created_at].to_s.match(/#{Date.today.to_s}.+/)).count
  	else
  		@order_data = "注文ゼロ！"
  	end
  end

end
