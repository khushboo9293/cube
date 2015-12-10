class CreateSharedContent < ActiveRecord::Migration
  def change
    create_table :shared_contents do |t|
      t.belongs_to :user, index: true
      t.belongs_to :content, index: true
      t.belongs_to :set_cube, index: true
      t.timestamps null: false
    end
  end
end
