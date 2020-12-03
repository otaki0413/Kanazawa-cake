class Member::OrdersController < ApplicationController
  before_action :not_null_cart, only: [:confirm, :new]
  before_action :authenticate_member!


  def new
    #注文者情報を入力する
    @order = Order.new
    @order.member_id = current_member.id
    @member = current_member
  end

  # 注文確認
  def confirm
    @order = Order.new(order_params)

    if params[:address_option] == 0
      # あなたの住所を表示
      @order.postcode = current_member.postcode
      @order.address = current_member.address
      @order.name = current_member.name

    elsif params[:address_option] == 1
      # 登録済み住所を表示
      @order.postcode = DeliveryGoal.find(params[:delivery]).postcode
      @order.address = DeliveryGoal.find(params[:delivery]).address
      @order.name = DeliveryGoal.find(params[:derivery]).name

    end
  end

  def index
  end

  def show
  end

  def create

  end


  def thanks
  end

  # ストロングパラメータ
  private
  def order_params
    params.require(:order).permit(  :member_id,
                                    :name,
                                    :postcode,
                                    :address,
                                    :payment_method,
                                    :total_payment,
                                    :freight,
                                    :status,
                                    # ordered_products_attributes: [:price, :stock, :product_id])
  end
end
