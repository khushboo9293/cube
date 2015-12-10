class CreateCube < ActiveRecord::Migration
  def change
    create_table :set_cubes do |t|
      t.string :name
      t.timestamps
    end
  end
end
