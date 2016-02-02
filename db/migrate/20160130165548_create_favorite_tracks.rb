class CreateFavoriteTracks < ActiveRecord::Migration
  def change
    create_table :favorite_tracks do |t|
      t.integer :track_id
      t.integer :user_id

      t.timestamps
    end
  end
end
