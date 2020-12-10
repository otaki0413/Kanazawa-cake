class OrderDetail < ApplicationRecord


  # ここはどうしてdependent: destroyしないのか？
  belongs_to :order
  belongs_to :product, dependent: :destroy
  # optional: trueは外部キーの値がなくても、DBに保存可能

	# 注文商品の小計
  def subtotal
    (product.no_tax_price*1.1*amount).round
  end


	enum making_status: { '着手不可': 0, '製作待ち': 1, '製作中': 2, '製作完了': 3 }
end
