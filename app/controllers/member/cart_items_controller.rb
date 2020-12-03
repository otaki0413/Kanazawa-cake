class Member::CartItemsController < ApplicationController
  before_action :authenticate_member!

  def index
    @cart_items = CartItem.all

  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.member_id = current_member.id
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
  end

  # ストロングパラメータ
  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :product_id)
  end
end
