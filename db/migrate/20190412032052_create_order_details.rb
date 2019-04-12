class CreateOrderDetails < ActiveRecord::Migration[5.1]
  def change
    create_table :order_details do |t|
      t.decimal :unit_price
      t.integer :quantity
      t.decimal :sub_total
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
