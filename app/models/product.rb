class Product < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  has_many :order_details, dependent: :destroy
  belongs_to :genre
  attachment :image
  # refileを使うために必須

  # バリデーション
  validates :genre_id,        presence: true
  validates :name,            presence: true
  validates :introduction,    presence: true
  validates :no_tax_price,    presence: true
  validates :is_active,       presence: true



  # 商品の税込価格のメソッド
  def tax_included_price
    (no_tax_price*1.1).round #roundは、数値を四捨五入
  end



end
