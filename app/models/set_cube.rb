class SetCube < ActiveRecord::Base
  has_many :shared_cubes, dependent: :delete_all
  has_many :users, :through => :shared_cubes
  has_many :contents
end
