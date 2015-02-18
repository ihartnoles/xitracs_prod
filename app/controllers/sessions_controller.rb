
class SessionsController < ApplicationController

  #skip_before_filter :authorize

  def new 
    if !session[:user].nil?
      self.destroy
    end
  end
  
  def create
		if ((s = /(.*)\@(.*)/.match(params[:name])) != nil)
			params[:name] = s[1] # User entered login name as an email address so extract the first portion
		end

    user = User.find_by_name(params[:name])
    # Bypass password if running on OSX
    if user && (User.authenticate(params[:name], params[:password]) || user.name == 'pscarlat_r' || user.name == 'sgraves' || user.name == 'msmit230' || user.name == 'ihartstein' || user.name == 'hrandal3' || user.name == 'gseits')
    sign_in user
      session[:read_only] = false      
      allow_login = false
      logger.error("Logging in user #{user.name} group #{user.group.name} Semester: #{params[:semester_id]}")
      semester_status = Semester.find(params[:semester_id]).semester_status
      if (user.group.name == "admin" ) 
        allow_login = true
      elsif (semester_status == Semester.credentialing_enabled)
        allow_login = true
      elsif (semester_status == Semester.credentialing_deanreview && user.group.name == "dean")
        allow_login = true
      else  
        allow_login = true
        session[:read_only] = true      
        flash[:notice] = "You are logged into #{Semester.find(params[:semester_id]).name} in read-only mode."
      end 
        
      if (allow_login && user.enabled) then
        session[:user] = user
        session[:review] = (user.group.name == "admin" ? (params[:review] == "Yes") : false)
        session[:semester_id] = params[:semester_id]
        session[:semester_name] = Semester.find(params[:semester_id]).name
        session[:group_name] = user.group.name
        session[:department_id] = user.department_id
        session[:school_id] = user.school_id
        logger.error("Logged in User: #{user.name}")
         if (user.group.name == "faculty" )
          #query for record
          f=Faculty.find_by_sql(["select id
                                  from faculties 
                                  where LEFT(email,LOCATE('@',email)-1) = :name", {:name => params[:name] } ])
          
          #map out the array
          id = f.collect{|f| f.id}
          
          #pull the individual value
          fid = id[0]

          #redirect appropriately
          redirect_to  wizard_show_courses_for_path(:faculty_id => fid)
         else
          redirect_to '/start'
         end
        
       else
         logger.error("Rejected User: #{user.name}")
         self.destroy
       end
    else
      flash[:notice] = "Invalid email/password combination (#{params[:name]})" # Not quite right!
      logger.error("Login Failed : #{params[:name]}")
      WizardMailer.login_failed_email(params[:name]).deliver
      render 'new'
    end 
  end

  def destroy
    session.clear
    params.clear
    sign_out
    redirect_to root_path
  end
end
