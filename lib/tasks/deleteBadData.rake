desc "Delete bad data "
task :delete_data => :environment do
	Bikehistory.where(['created_at > ?', DateTime.new(2016,9,1)]).delete_all
end