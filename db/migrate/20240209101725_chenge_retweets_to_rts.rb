class ChengeRetweetsToRts < ActiveRecord::Migration[6.1]
  def change
    rename_table :retweets, :rts
  end
end
