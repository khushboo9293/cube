class Content < ActiveRecord::Base
	belongs_to :set_cubes
	has_many :shared_contents, dependent: :delete_all
end