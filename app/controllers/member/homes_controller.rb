class Member::HomesController < ApplicationController

  # なぜここで、Productモデルを使えるの？？アソシエーションなしで、他モデルを参照できる？
  def top
    @products = Product.all
  end

  def about
  end
end
