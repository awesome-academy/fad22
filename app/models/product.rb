class Product < ApplicationRecord
  belongs_to :category
  has_many :order_details, dependent: :destroy
  has_many :comments, dependent: :destroy
  enum status: {normal: 0, deleted: 1}
  mount_uploader :image_link, ImageLinkUploader
  scope :order_by_name, ->{order(name: :DESC)}
  scope :find_product, ->(status){where(status: status)}
end
