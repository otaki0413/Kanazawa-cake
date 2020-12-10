class Order < ApplicationRecord

  # 注文情報のバリデーション
   validates :payment_method,    presence: true
  validates :postcode,          presence: true
  validates :address,           presence: true
  validates :name,              presence: true

  belongs_to :member
  has_many :order_details, dependent: :destroy




  # enum 支払い方法
  enum payment_method: { credit_card: 0, bank_transfer: 1, cash_change: 2 }

  # enum 注文ステータス
  enum status: { '入金待ち': 0, '入金確認': 1, '製作中': 2, '発送準備中': 3, '発送済み': 4 }
end
