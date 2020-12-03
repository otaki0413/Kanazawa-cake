class DeliveryGoal < ApplicationRecord

  belongs_to :member

  # バリデーション
  validates :postal_code,     presence: true
  validates :address,         presence: true
  validates :name,        　　presence: true

  # 　self付けなくてもいい
  def full_deliveries
    self.postcode + " " + self.address + " " + self.name
  end
end
