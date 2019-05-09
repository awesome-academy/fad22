class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  enum role: {normal: 0, admin: 1}
  scope :order_desc, ->{order created_at: :desc}
end
