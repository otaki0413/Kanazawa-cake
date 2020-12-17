class Member::HomesController < ApplicationController

  def top
    # オススメ商品を4つ表示
    @products = Product.first(4)
    @genres = Genre.all
  end

  def about
  end
end
