class CreateTmessages < ActiveRecord::Migration
  def change
    create_table :tmessages do |t|
      t.string :message
      t.string :destination
      t.datetime :published
      t.references :user
      t.timestamps
    end
  end
end
