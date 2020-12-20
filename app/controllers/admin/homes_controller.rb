class Admin::HomesController < ApplicationController

  # 本日の注文件数
  def top
    @orders = Order.all
    @order_data = 0

    # 今日の注文日とマッチする度に、@order_dataに加算していく
    @orders.each do |order|
    	if (order[:created_at].to_s.match(/#{Date.today.to_s}.+/))
    		@order_data = @order_data + 1
    	end
    end

  end

end
