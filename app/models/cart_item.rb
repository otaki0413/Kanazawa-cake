class CartItem < ApplicationRecord

  belongs_to :product
  belongs_to :member
end
