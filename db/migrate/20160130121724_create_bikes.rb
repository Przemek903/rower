class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :number
      t.integer :count

      t.timestamps
    end
  end
end
