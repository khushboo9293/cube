class ChangeColumnSharedCube < ActiveRecord::Migration
  def change
  	remove_column :shared_cubes, :parent_id
    remove_column :shared_cubes, :shared_content
    add_column :shared_cubes, :is_shared, :boolean, :default => false
  end
end
