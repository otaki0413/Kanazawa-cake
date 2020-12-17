class Admin::ProductsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @products = Product.all
  end

  def new
    @newproduct = Product.new
  end

  # 商品新規登録
  def create
    @newproduct = Product.new(product_params)
    if @newproduct.save
      flash[:notice] = "You have created product successfully."
      redirect_to admin_product_path(@newproduct.id)
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  
  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      flash[:notice] = "You have updated product successfully."
      redirect_to admin_products_path
    else
      render :edit
    end
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
