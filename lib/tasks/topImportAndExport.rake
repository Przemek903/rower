desc "Find most import and export clusters"
task :import_export => :environment do
  numberOfClusters = 50
  totalImportToClusters = {}
  totalExportForClusters = {}
  (1..numberOfClusters).each do |clusterNumber|
    importSum = 0
    exportSum = 0
    clusterImportTraffics = ClusterTraffic.where(toCluster: clusterNumber)
    clusterExportTraffics = ClusterTraffic.where(fromCluster: clusterNumber)
    clusterImportTraffics.each do |importCluster|
      importSum = importSum + importCluster.count
    end
    clusterExportTraffics.each do |exportCluster|
      exportSum = exportSum + exportCluster.count
    end
    totalImportToClusters[clusterNumber] = importSum
    totalExportForClusters[clusterNumber] = exportSum
  end
  p totalImportToClusters
  p totalExportForClusters
end