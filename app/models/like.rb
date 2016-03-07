class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :assignment

	#put validations for mandatory check user_id and assignment_id present
end
