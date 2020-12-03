class Member::ProductsController < ApplicationController
  before_action :authenticate_member!

  def index
    @genres = Genre.all
    @products = Product.all

  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
    # 商品データを入れる空のインスタンスを作る
    @cart_item = CartItem.new
  end

  
end
