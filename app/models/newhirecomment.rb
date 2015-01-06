class Newhirecomment < ActiveRecord::Base

	def signed_off_by(user_id)
		username = User.find_by_id(user_id)

		if !username.nil?
			return username.name
		else
			return "n/a - comment"
		end
	end
end
