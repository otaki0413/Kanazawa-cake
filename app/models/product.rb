class Product < ApplicationRecord

  belongs_to :genre
  has_many :cart_items
  # refileを使うために必須
  attachment :image
end
