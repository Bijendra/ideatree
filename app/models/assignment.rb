class Assignment < ActiveRecord::Base

	belongs_to :user
	has_many :tags
	belongs_to :category
end
