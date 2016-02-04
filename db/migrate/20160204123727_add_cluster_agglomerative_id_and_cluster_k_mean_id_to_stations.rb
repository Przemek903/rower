class AddClusterAgglomerativeIdAndClusterKMeanIdToStations < ActiveRecord::Migration
  def change
    add_column :stations, :clusterAgglomerative_id, :integer
    add_column :stations, :clusterKMean_id, :integer
  end
end
