class Member::CartItemsController < ApplicationController
  before_action :authenticate_member!

  def index
    @cart_item = CartItem.new #エラーメッセージ用
    @cart_items = current_member.cart_items # @cart_items = CartItem.all → これだと他のユーザーのカート情報も含んでしまう。

    # 合計金額は、0スタートの小計追加ごとに増加していく
    @total_price = 0
    @cart_items.each do |cart|
      @total_price += cart.subtotal
    end
  end


  def create
    # @cart_item.member_id = current_member.idは,下の記述で、まとめて入っている
    @cart_item = current_member.cart_items.new(cart_item_params)

    # 現時点でのカートアイテム
    @current_item = current_member.cart_items
    # カートに追加した商品が既にカートに存在していれば、数量だけを増やす
    if @current_item.find_by(product_id: params[:cart_item][:product_id]).present?
      @cart_item.amount += params[:cart_item][:amount].to_i
      # binding.pry
      @cart_item.save
      flash[:notice] = "Same Item was successfully added to cart."
      redirect_to cart_items_path
    else
      @cart_item.save
      flash[:notice] = "New Item was successfully added to cart."
      redirect_to cart_items_path
    end
  end


  # 商品の個数を変更する
  def update
    @cart_item = CartItem.find(params[:id])
    # @cart_item = CartItem.find_by(member_id: params[:member_id])
    # @cart_item.member_id = current_member.id
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  # カート内の1商品を削除する
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to request.referer
    前の
  end

  # カートを空にする
  def all_destroy
    cart_items = current_member.cart_items
    cart_items.destroy_all
    redirect_to request.referer
  end

  # ストロングパラメータ
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :product_id, :member_id)
  end
end
