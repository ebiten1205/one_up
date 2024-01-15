class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :notificatable, polymorphic: true
      t.references :customer, foreign_key: true, null: false
      t.integer :action_type, null: false
      t.boolean :checked, default: false, null: false
      t.integer "visitor_id"
      t.integer "visited_id"
      t.timestamps
    end
  end
end
