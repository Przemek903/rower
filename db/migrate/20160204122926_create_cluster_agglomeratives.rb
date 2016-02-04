class CreateClusterAgglomeratives < ActiveRecord::Migration
  def change
    create_table :cluster_agglomeratives do |t|
      t.float :lat
      t.float :lng
      t.integer :numberOfStations

      t.timestamps
    end
  end
end
