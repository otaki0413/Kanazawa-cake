class Product < ApplicationRecord

  belongs_to :genre
  # refileを使うために必須
  attachment :image
end
