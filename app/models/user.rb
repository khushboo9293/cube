class User < ActiveRecord::Base
  has_many :shared_cubes
  has_many :set_cubes, :through => :shared_cubes
end