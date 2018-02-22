class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date_played
      t.integer :user_id
      t.integer :opponent_id
      t.integer :user_score, default: 0
      t.integer :opponent_score, default: 0
      t.boolean :won, default: false

      t.timestamps null: false
    end
  end
end
