class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.integer :quantity
      t.string :image_link
      t.integer :status, default: 0
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
