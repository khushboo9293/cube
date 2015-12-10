class SharedCube < ActiveRecord::Base
  belongs_to :users
  belongs_to :set_cubes
end