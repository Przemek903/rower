class AddIndexToCreatedAtAndBikeNumbersFromBikehistory < ActiveRecord::Migration
  def change
    add_index :bikehistories, :created_at
    add_index :bikehistories, :bike_numbers
  end
end
