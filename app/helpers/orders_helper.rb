module OrdersHelper
  def find_order_by_product_id id
    Order.includes("order_details").where(status: "delivering",
      order_details: {product_id: id})
  end
end
