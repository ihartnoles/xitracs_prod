module SessionsHelper
  
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = user.id
    self.current_user = user
    logger.error("SessionHelper:login: Setting user to #{user.name}")
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def current_user?(user)
    user == current_user
  end
  
  def authenticate
    deny_access unless signed_in?
  end
  
  private

    def user_from_remember_token
      remember_token && User.find(remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || nil
    end

end