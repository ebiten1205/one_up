class CreateTimelines < ActiveRecord::Migration[6.1]
  def change
    create_table :timelines do |t|
      t.integer :customer_id, null: false
      t.integer :post_id
      t.integer :rt_id
      t.string :timelineable_type, null: false
      t.timestamps
    end
  end
end
