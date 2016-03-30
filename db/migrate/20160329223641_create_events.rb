class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.integer :track_ids, array: true, default: []
      t.datetime :start
      t.datetime :finish

      t.timestamps null: false
    end
  end
end
