class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :oauth_token
      t.string :oauth_secret
      t.string :latch_id
      t.integer :last_tweet,  :limit => 8
      t.integer :last_pm,  :limit => 8
      t.references :ttweets
      t.references :tmessages
      t.timestamps
    end
  end
end
