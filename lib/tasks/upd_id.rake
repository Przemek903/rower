desc "UpdateId"
task :update_id => :environment do
  (3..50).each do |num|
    ClusterKMean.find(50+num).update_attributes(id: num)
  end
end