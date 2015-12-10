class Content < ActiveRecord::Migration
  def change
  	create_table :contents do |t|
  	  t.references :set_cube, index: true
      t.text :link
      t.timestamps
    end
  end
end
