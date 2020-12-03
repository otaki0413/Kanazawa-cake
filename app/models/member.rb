class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :first_name,        presence: true
  validates :last_name,         presence: true
  validates :first_kana,        presence: true
  validates :last_kana,         presence: true
  validates :email,             presence: true
  validates :postcode,          presence: true
  validates :address,           presence: true
  validates :phone_number,      presence: true


  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :delivery_goals, dependent: :destroy


  def my_address
    self.postcode + " " + self.address + " " + self.last_name + " " + self.first_name
  end

  # どうしてこんなことできる??
  def name
    [first_name,last_name].join(' ')
  end

  def kana
    [first_kana,last_kana].join(' ')
  end
end
