class Member::CartItemsController < ApplicationController
  before_action :authenticate_member!

  def index
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.member_id = current_member.id
    # カート内商品IDとカートに入れた商品IDを一緒にしたい
    # @cart_item.product_id = Product.find(params[:i
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
  end

  def destroy
  end

  def all_destroy
  end

  # ストロングパラメータ
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end
end
