class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーション
  validates :first_name,        presence: true
  validates :last_name,         presence: true
  validates :first_name_kana,   presence: true
  validates :last_name_kana,    presence: true
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


  def name
    self.last_name + self.first_name
  end

  # やっていることは上と同じ、文字列の結合
  def kana
    [last_name_kana,first_name_kana].join(' ')
  end

  # 退会ユーザーをログインできないようにする
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

end
