class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @newproduct = Product.new
  end

  # 商品新規登録
  def create
    @newproduct = Product.new(product_params)
    @newproduct.save
    flash[:notice] = "You have created product successfully."
    redirect_to admin_product_path(@newproduct.id)
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    @product.update(product_params)
    flash[:notice] = "You have updated product successfully."
    redirect_to admin_products_path
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to admin_products_path
  end

  # ストロングパラメータ
  private
  def product_params
    params.require(:product).permit(:genre_id, :name, :image, :introduction, :no_tax_price, :is_active)
  end

end
