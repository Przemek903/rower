class AddCountToWeathers < ActiveRecord::Migration
  def change
    add_column :weathers, :count, :integer
  end
end
