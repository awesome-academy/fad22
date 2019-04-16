class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :delivery_address
      t.integer :status, default: 0
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
