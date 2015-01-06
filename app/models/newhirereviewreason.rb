class Newhirereviewreason < ActiveRecord::Base

	def reviewer_name(reviewer_id)

		#username = User.find(reviewer_id).name

		#return username

		username = User.find_by_id(reviewer_id)

		if !username.nil?
			return username.name
		else
			return "n/a - reviewreason"
		end

	end

	def review_state_name(review_state)

		case review_state

			when 0
				statename = 'Pending'
			when 1
				statename = 'Passed'
			when 2
				statename = 'Not Passed'
			else
				statename = 'Unknown'
			end

		return statename
		
	end
end
