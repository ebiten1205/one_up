class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :customer_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
  end
end
