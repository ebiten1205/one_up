class CreateTimelines < ActiveRecord::Migration[6.1]
  def change
    create_table :timelines do |t|
      t.integer :customer_id, null: false
      t.integer :timelineable_id, null: false
      t.string :timelineable_type, null: false
      t.timestamps
    end
  end
end
