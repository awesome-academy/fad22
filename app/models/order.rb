class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :destroy
  enum status: {waiting: 0, delivering: 1, delivered: 2, cancel: 3}
  before_save :update_total
  scope :find_order_by_status, ->(status){where(status: status)}
  def total
    order_details.map{|od| od.valid? ? od.quantity * od.unit_price : 0}.sum
  end

  def reduce_quantity_product
    @order_details = order_details
    @order_details.each do |od|
      @product = Product.find_by id: od.product_id
      @product.update_attributes(quantity: (@product.quantity - od.quantity))
    end
  end

  def restore_quantity_product
    @order_details = order_details
    @order_details.each do |od|
      @product = Product.find_by id: od.product_id
      @product.update_attributes(quantity: (@product.quantity + od.quantity))
    end
  end

  private

  def update_total
    self[:total] = total
  end
end
