class WizardMailer < ActionMailer::Base
  default from: "ihartstein@fau.edu"
  
  def new_user_email(user)
    @user = user
    mail(:from => "#{@user.name}@fau.edu", :to => 'ihartstein@fau.edu', :subject => "New SACS User Request: #{@user.name}")
  end
  
  def login_failed_email(username)
    @username = username
    mail(:from => "#{@username}@fau.edu", :to => 'ihartstein@fau.edu', :subject => "Failed Login: #{@username}")
  end

  def send_msg(newhire,subject,msg,sendto,body,sentby,final_approval)
  	@newhire = newhire
    @subject = subject
    @msg = msg
    @sendto = sendto
    @bodymsg = body
    @sentby = sentby


    if (final_approval == 1)
       mail(:from => "mwalsh8@fau.edu", :to => "#{@sendto}@fau.edu", :subject => "#{@subject}", :cc => ["alperind@fau.edu","ebenne12@fau.edu"])        
    else
       mail(:from => "#{@sentby}@fau.edu", :to => "#{@sendto}@fau.edu", :subject => "#{@subject}")
    end
  end

end
