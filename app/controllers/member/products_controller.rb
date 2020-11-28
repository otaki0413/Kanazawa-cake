class Member::ProductsController < ApplicationController
  before_action :authenticate_member!

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
end
