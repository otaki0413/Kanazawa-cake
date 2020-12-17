class Member::OrdersController < ApplicationController

  before_action :not_null_cart_item, only: [:new, :confirm]
  before_action :authenticate_member!

  #注文者情報を入力する
  def new
    @order = Order.new
    @order.member_id = current_member.id
    @member = current_member
  end


  # 注文情報確認--------------------------------------------------
  def confirm
    @order = Order.new
    @cart_items = current_member.cart_items # これは関連付けがなされているからできる？？会員IDから引っ張ってきている?

    # 支払い方法
    @order.payment_method = params[:payment_method]

    # ------お届け先の3パターン →→ address_option別で場合分け-
    if params[:address_option] == "0"
      # あなたの住所を表示
      @order.postcode = current_member.postcode
      @order.address = current_member.address
      @order.name = current_member.name

    elsif params[:address_option] == "1"
      # 登録済み住所を表示
      @order.postcode = DeliveryGoal.find(params[:delivery]).postcode
      @order.address = DeliveryGoal.find(params[:delivery]).address
      @order.name = DeliveryGoal.find(params[:delivery]).name

    else params[:address_option] == "2"
      # 新規の住所を表示
      @order.postcode = params[:postcode]
      @order.address = params[:address]
      @order.name = params[:name]
      # binding.pry
    end

    # 合計金額　(subtotalは、CartItemモデルで定義済み)
    @total_payment = 0
    @cart_items.each do |cart|
      @total_payment += cart.subtotal.to_i
    end
    # 請求金額
    @freight_total_payment = @total_payment + @order.freight
  end


  # 購入を確定する--------------------------------------------------
  def create

    @order = Order.new(order_params)
    @order.member_id = current_member.id

    if @order.save
      # 注文データを注文詳細のDBにも保存する
      @current_items = current_member.cart_items
      @current_items.each do |item|
        @order_detail = OrderDetail.new #注文商品の空のモデルを作る
        @order_detail.product_id = item.product.id
        @order_detail.order_id = @order.id  #orderがセーブされたあとじゃないといけない。
        @order_detail.price = item.product.tax_included_price
        @order_detail.amount = item.amount
        @order_detail.save
      end

      @current_items.destroy_all # 現時点でのカートアイテムのデータを全て削除
      redirect_to orders_thanks_path
    else
      # @order = Order.new → これだとエラーメッセージが表示できない。サラの状態でnewが返ってくる
      @order.member_id = current_member.id
      @member = current_member
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = current_member.orders.order(created_at: :desc) #新しい物が上に来るように並び替える
    # binding.pry
  end

  def show
    @order = Order.find(params[:id])

    # 合計金額
    @total_payment = 0
    @order.order_details.each do |order_item|
      @total_payment += order_item.subtotal.to_i
    end

    # 請求金額
    @freight_total_payment = @total_payment + @order.freight

  end


  # ストロングパラメータ
  private
  def order_params
    params.require(:order).permit(:member_id, :name, :postcode, :address, :payment_method, :total_payment, :freight, :status, :address_option)
  end

  #カートがNullであればredirect_back
  def not_null_cart_item
    if current_member.cart_items.empty?
      flash[:alert] = "カートに商品を入れてください!!"
      redirect_back(fallback_location: root_path)
    end
  end

end
