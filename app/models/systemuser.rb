class Systemuser < ActiveRecord::Base
	self.table_name = "users"


	def getDeptName(id)
		deptname = Department.find(id).name

		return deptname
	end

	def getSchoolName(id)
		schoolname = School.find(id).description

		return schoolname
	end

	def getPermissionName(id)
		case id
			when 1
				permissionname = "authorized user"
			when 2
				permissionname = "chair"
			when 4
				permissionname = "dean"
			when 8
				permissionname = "review"
			when 16
				permissionname = "admin"
			else
				permissionname = "n/a"
		end

		return permissionname
	end

	def getGroupName(id)
		case id
			when 1
				permissionname = "admin"
			when 2
				permissionname = "dean"
			when 3
				permissionname = "chair"
			when 4
				permissionname = "faculty"			
			else
				permissionname = "n/a"
		end

		return permissionname
	end
end
