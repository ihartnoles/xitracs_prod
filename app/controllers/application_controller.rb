class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
	force_ssl

  #before_filter CASClient::Frameworks::Rails::Filter

  unless Rails.application.config.consider_all_requests_local
		  rescue_from Exception,
		              :with => :render_error
		  rescue_from ActiveRecord::RecordNotFound,
		              :with => :render_not_found
		  rescue_from ActionController::RoutingError,
		              :with => :render_not_found
		  rescue_from ActionController::UnknownController,
		              :with => :render_not_found
		  rescue_from ActionController::UnknownAction,
		              :with => :render_not_found
	end

	protected
		def render_not_found(exception)
		   render :file => 'public/400.html',  :status => :not_found, :layout => false

		    
		end

	protected
		def render_error(exception)
		  ExceptionNotifier::Notifier
		    .exception_notification(request.env, exception)
		    .deliver
		   render :file => 'public/500.html',  :status => :not_found, :layout => false

		end
end
