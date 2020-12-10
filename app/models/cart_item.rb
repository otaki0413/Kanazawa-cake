class CartItem < ApplicationRecord

  belongs_to :product
  belongs_to :member

  # 全角文字を弾く。0より大きくて10より小さくないといけない。
  validates :amount, numericality: { only_integer: true,	greater_than: 0, less_than: 10}

  # 商品の税込価格のメソッド
  def tax_included_price
    (product.no_tax_price * 1.1).round #roundは、数値を四捨五入
  end

  # 小計のメソッド
  def subtotal
    (product.no_tax_price * 1.1 * amount).round
  end


end
