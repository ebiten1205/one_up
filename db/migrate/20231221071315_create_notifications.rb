class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.string :visitor_id, null: false
      t.string :visited_id, null: false
      t.integer :notificatable_id, null: false
      t.string :notificatable_type, null: false
      t.boolean :checked, default: false, null: false
      t.timestamps
    end
  end
end
