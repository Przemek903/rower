class CreateClusterKMeans < ActiveRecord::Migration
  def change
    create_table :cluster_k_means do |t|
      t.float :lat
      t.float :lng
      t.integer :numberOfStations

      t.timestamps
    end
  end
end
