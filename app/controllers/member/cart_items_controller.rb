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
    # .newは新規の商品データを追加する時のみに使う、今回だとelse以下
    @cart_item = current_member.cart_items.new(cart_item_params)

    # 現時点でのカートアイテム
    @current_items = current_member.cart_items
    # カートに追加した商品が既にカートに存在していれば、数量だけを増やす
    if @current_items.find_by(product_id: params[:cart_item][:product_id]).present?
      @present_item = @current_items.find_by(product_id: params[:cart_item][:product_id])
      @present_item.amount = @present_item.amount.to_i + params[:cart_item][:amount].to_i
      # @present_item.update(cart_item_params)
      @present_item.update(amount: @present_item.amount)
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
    # @cart_item.member_id = current_member.idは既にDBに保存されている
    if @cart_item.update(cart_item_params)
      redirect_to cart_items_path
    else
      # renderするからindexの再記述
      @cart_items = current_member.cart_items
      @total_price = 0
      @cart_items.each do |cart|
        @total_price += cart.subtotal
      end
      render :index
    end
  end


  # カート内の1商品を削除する
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_back(fallback_location: root_path)
    # 前のアクションに飛ぶ
  end


  # カートを空にする
  def all_destroy
    cart_items = current_member.cart_items
    cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end

  # ストロングパラメータ
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :product_id, :member_id)
  end
end
