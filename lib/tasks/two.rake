desc "FillTwoDirectionTraffic"
task :two_direction => :environment do
  TwoDirectionTraffic.delete_all
  ClusterTraffic.all.each do |traf|
    if TwoDirectionTraffic.where(stationA_id: traf.toCluster, stationB_id: traf.fromCluster).exists?
      actual = TwoDirectionTraffic.where(stationA_id: traf.toCluster, stationB_id: traf.fromCluster).first
      newSum = actual.totalCount + traf.count
      actual.update_attributes(formSecondToFirst: traf.count, totalCount: newSum)
        # if NewModel.where(from: traf.to, to: traf.from).exists?
        #   actual = NewModel.where(from: traf.to, to: traf.from)
        #   newSum = actual.sum + traf.count
        #   actual.update(fromBtoA: traf.count, sum: newSum)
        # else
        #   NewModel.create(StatA: traf.from, StatB: traf.to, fromAtoB: traf.count, sum: traf.count)
        # end
    else
      TwoDirectionTraffic.create(stationA_id: traf.fromCluster, stationB_id: traf.toCluster,
                                 fromFirstToSecond: traf.count, totalCount: traf.count)
    end
  end
end

# done