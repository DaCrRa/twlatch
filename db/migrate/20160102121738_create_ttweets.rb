class CreateTtweets < ActiveRecord::Migration
  def change
    create_table :ttweets do |t|
      t.string :tweet
      t.datetime :published
      t.references :user
      t.timestamps
    end
  end
end
