class CreateClusterTraffics < ActiveRecord::Migration
  def change
    create_table :cluster_traffics do |t|
      t.integer :fromCluster
      t.integer :toCluster
      t.integer :count

      t.timestamps
    end
  end
end
