class CreateHireWeeks < ActiveRecord::Migration
  def change
    create_table :hire_weeks do |t|
      t.string :name
      t.integer :count

      t.timestamps
    end
  end
end
