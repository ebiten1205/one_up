class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.string :place, null: false
      t.timestamps
      t.integer :customer_id, null: false
      t.integer :genre_id, null: false
    end
  end
end
