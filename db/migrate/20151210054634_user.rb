class User < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :city
      t.timestamps null: false	
    end
  end
end
