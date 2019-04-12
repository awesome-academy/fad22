class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
      t.string :title
      t.text :content
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
