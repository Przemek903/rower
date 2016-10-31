class ChangeStationBFormTwoDiresctionTrafficToStationBId < ActiveRecord::Migration
  def change
    rename_column :two_direction_traffics, :stationB, :stationB_id
  end
end
