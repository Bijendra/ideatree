class Follow < ActiveRecord::Base

	belongs_to :user
# any new object types should be added here
	USER = 1
	IDEA = 2
end
