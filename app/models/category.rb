class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true
  enum status: {normal: 0, deleted: 1}
  scope :order_follow_created_at, ->{order(created_at: :DESC)}
  scope :find_categories, ->(status){where(status: status)}
end
