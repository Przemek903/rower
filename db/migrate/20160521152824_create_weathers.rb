class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.integer :max_temp
      t.integer :min_temp
      t.integer :avg_temp
      t.string :conditions
      t.datetime :date

      t.timestamps
    end
  end
end
