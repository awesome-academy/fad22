class AddProductToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :product, foreign_key: true
  end
end
