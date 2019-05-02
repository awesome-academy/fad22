class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  enum status: {waiting: 0, delivering: 1, delivered: 2}
  before_save :update_total

  def total
    order_details.map{|od| od.valid? ? od.quantity * od.unit_price : 0}.sum
  end

  private

  def update_total
    self[:total] = total
  end
end
