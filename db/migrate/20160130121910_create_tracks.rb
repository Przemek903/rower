class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :fromStation
      t.integer :toStation
      t.integer :count

      t.timestamps
    end
  end
end
