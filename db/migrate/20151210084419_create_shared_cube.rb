class CreateSharedCube < ActiveRecord::Migration
  def change
    create_table :shared_cubes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :set_cube, index: true
      t.integer :parent_id
      t.json :shared_content
      t.timestamps null: false
    end
  end
end
