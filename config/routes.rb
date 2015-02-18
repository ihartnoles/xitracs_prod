XitracsRoster::Application.routes.draw do



  
  resources :systemusers

  resources :newhirecredentials

  resources :donesemesters
  resources :reviewreasons
  resources :semesters
  resources :users
  #resources :precredentialing
  resources :newhires do
     collection do
        post 'savename'
        get  'review_course'
        post 'review_course'
        get  'list'
        get  'departments'
        post 'departments'
        get  'list_pending'
        get  'list_by_dept'
        get  'list_by_school'
        get  'send_review_msg'
        post 'send_review_msg'
        get  'approve_course'
        post 'approve_course'
        put  'approve_course'
        get  'review_msg'
        get  'schools'
        get  'signoff'
        get  'review_dialog'
        post 'save_review'
        get  'save_signoff'
        post 'save_signoff'       
        get  'delete_review'
        post 'delete_review'
        get  'delete_signoff'
        post 'delete_signoff'
        get  'delete_newhire'
        post 'delete_newhire'
        get  'assign_to'
        post 'assign_to'
        get  'update_dept_select'
       
       end
  end

  resources :newhirecourses
  resources :newhirecredits
  resources :newhirecomment
  resources :newhiredocuments do
     collection do
        get  'uploadform'
        post 'uploadform'
        get  'file_download'
        get  'save_verified_doc'
        post 'save_verified_doc'
        get  'term_degree_download'
    end
  end


   resources :coursedocuments do
     collection do
        get  'display_doc_form'
        post 'display_doc_form'   
        get   'file_download'     
        get   'download_dialog'
        post  'download_dialog'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "/quick/criteria"
  get "/quick/dean_signoff"
  get "/quick/mark_signed_off"
  get "/quick/show_reason_details"

  get "/report/users"
  get "/report/summary"
  get "/report/search_by_credit_course"
  get "/report/report_not_passed"
  get "/report/report_not_passed_detailed"
  get "/report/report_criteria"
  get "/report/report_credentialing_not_completed"
  get "/report/report_credentialing"
  get "/report/report_not_passed_and_not_deansignoff"
  get "/report/report_reviewstate"
  get "/report/course_and_faculty_summary"
  get "/report/report_faculty_course"
  get "/report/report_missing_syllabi"


  get "wizard/course"
  get "wizard/faculty"
  get "wizard/department"
  get "wizard/show_courses_for"
  get "wizard/show_course_summary"

  get "wizard/justify_course_for"
  get "wizard/approve_course_for"
  put "wizard/approve_course_for"
  get "wizard/approve_course_done"

  get "wizard/process_justification"
  put "wizard/process_justification"
  post "wizard/process_justification"
  get "wizard/process_justification_done"
  post "wizard/process_justification_done"

  get "wizard/process_justification_signoff_or_done"

  get "wizard/process_justification_deansignoff"
  put "wizard/process_justification_deansignoff"
  
  get "/wizard/process_justification_comments"
  post "/wizard/process_justification_comments"
  put "/wizard/process_justification_comments"
  get "/wizard/process_justification_exception"
  post "/wizard/process_justification_exception"
  put "/wizard/process_justification_exception"
  put "/wizard/process_reason_facultycredential"

 
  get "/wizard/find"
  get "/wizard/process_justification_coursework"
  put "/wizard/process_justification_coursework"
  post "/wizard/process_justification_coursework"
  post "/sessions/create"

  get  "/coursedocuments/download_dialog"
  post "/coursedocuments/download_dialog"

  post "/coursedocuments/file_upload"
  put  "/coursedocuments/file_upload"
  get  "/coursedocuments/file_download"

  get  "/coursedocuments/file_download"
  get  "/coursedocuments/file_download"
  get "users/new"

  #get "/precredentialing/credentialsform"
  #get "/precredentialing/name"
  #get "/precredentialing/courses"

  #post "/precredentialing/savecomments"
  #put "/precredentialing/savecomments"
  #post "/precredentialing/file_upload"
  #put "/precredentialing/file_upload"
  
  post "newhires/courses"
  post "newhires/create"
  
  get  "newhires/review_course"
  post "newhires/review_course"
  
  get  "/newhires/approve_course"
  post "/newhires/approve_course"
  put "/newhires/approve_course"

  get  "newhires/list"
  
  get   "newhires/list_pending"

  get   "newhires/list_by_dept"

  get   "newhires/list_by_school"

  #get   "newhires/schools"
  
  post "/newhires/process_justification_deansignoff"
  post "/newhires/process_signoff"

  get  "/newhires/review_msg"
  
  get  "/newhires/signoff"
  get  "/newhires/review_dialog"
  post "/newhires/save_review"
  post "/newhires/save_signoff"
  post "newhires/send_review_msg"
  post "/newhires/delete_signoff"
  post "/newhires/delete_review"
  post "/newhires/delete_newhire"
  post "/newhires/assign_to"

  post "/newhires/savename"

  get  "/newhires/update_dept_select"
  
  get  "/newhiredocuments/uploadform"
  post "/newhiredocuments/uploadform"
  post "/newhiredocuments/save_verified_doc"

  post "/newhiredocuments/file_upload"
  put  "/newhiredocuments/file_upload"

  get  "/newhiredocuments/file_download"
  get  "/newhiredocuments/term_degree_download"

  get  "/newhiredocuments/uploadstatus"
  post "/newhiredocuments/uploadstatus"

  get  "newhirecomment/index"
  get  "newhirecomment/create"
  post "newhirecomment/create"

  root to: 'sessions#new'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/start', to: 'static_pages#start'
  match '/reports', to: 'report#index'
  match '/quick', to: 'quick#index'
  #match '/precredentialing', to: 'static_pages#precredentialing'

  match '/register', to: 'static_pages#register'

  match '/reports', to: 'report#index'
  match '/login',  to: 'sessions#new'
  match '/logout', to: 'sessions#destroy'

  match "/newhires/:id/displaydetails" => 'newhires#displaydetails', :as => :newhiredetails
  match "/newhires/review_course" => 'newhires#review_course', :as => :newhire_review_course
  match "/newhires/departments" => 'newhires#departments', :as => :newhire_showdepartments
  match "/newhires/:id/showcourses" => 'newhires#showcourses', :as => :newhireshowcourses
  match "/newhires/list_pending" => 'newhires#list_pending' , :as => :newhire_listpending
  match "/newhires/list_by_dept" => 'newhires#list_by_dept' , :as => :newhire_listbydept
  match "/newhires/list_by_school" => 'newhires#list_by_school' , :as => :newhire_listbyschool
  match '/newhires/send_review_msg', to: 'newhires#send_review_msg' , :as => :newhire_send_review_msg
  match '/newhires/approve_course', to: 'newhires#approve_course' , :as => :newhire_approve_course
  match '/newhires/schools', to: 'newhires#schools' , :as => :newhire_schools
  match '/newhires/save_signoff', to: 'newhires#save_signoff' , :as => :newhire_save_signoff
  match '/newhiredocuments/save_verified_doc', to: 'newhiredocuments#save_verified_doc' , :as => :newhiredocuments_save_verified_doc
  match '/newhires/assign_to', to: 'newhires#assign_to', :as => :newhire_assign_to
  match '/newhires/delete_review', to: 'newhires#delete_review' , :as => :newhire_delete_review
  match '/newhires/delete_signoff', to: 'newhires#delete_signoff' , :as => :newhire_delete_signoff
  match '/newhires/delete_newhire', to: 'newhires#delete_newhire' , :as => :newhire_delete_newhire
  match '/newhires/update_dept_select/:id' , to: 'newhires#update_dept_select', :as =>  :newhire_update_dept_select
  match '*a', :to => 'newhires#routing_error'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
