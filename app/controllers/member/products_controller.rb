class Member::ProductsController < ApplicationController
  before_action :authenticate_member!

  def index
    @genres = Genre.all
    @products = Product.all

  end

  def show
    @genres = Genre.all
    @product = Product.find(params[:id])
  end
end
