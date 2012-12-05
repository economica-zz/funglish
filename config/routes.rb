Funglish::Application.routes.draw do
  root :to => "top#index"

  match "terms_of_service" => "terms_of_service#index"
  match "privacy_policy" => "privacy_policy#index"
  match "act_of_spec_com_tran" => "act_of_spec_com_tran#index"
  match "company_outline" => "company_outline#index"
  match "inquiry" => "inquiry#index"
  match "auth" => "auth#login_signup"
  match "logout" => "logout#index"
  match "lesson_materials/download_file/:id" => "lesson_materials#download_file"
  match "lessons/get_schedule_list/:id" => "lessons#get_schedule_list"
  match "comments/get_comment_list/:id" => "comments#get_comment_list"
  match "schedule_comments/get_schedule_comment_list/:id" => "schedule_comments#get_schedule_comment_list"
  match "paypal/checkout/:id" => "paypal#checkout"
  match "paypal/confirm/:id" => "paypal#confirm"
  match "paypal/cancel/:id" => "paypal#cancel"
  match "apply" => "top#apply"
  match "register" => "top#register"
  match "lesson" => "top#lesson"
  match "history" => "top#history"
  match "email_address_confirmation" => "email_address_confirmation#index"
  match "email_address_confirmation/complete/:facebook_id/:email_address_confirmation_code" => "email_address_confirmation#complete"

  post "schedules/create_from_lesson"
  post "schedules/delete_schedule"
  post "schedules/delete_schedule_top"
  post "schedules/delete_schedule_top_history"
  post "schedules/delete_schedule_detail"
  post "guests/approve_request"
  post "guests/decline_request"
  post "guests/cancel_request"
  post "guests/cancel_request_detail"
  post "comments/delete_comment"
  post "comments/register_comment_child"
  post "comments/delete_comment_child"
  post "paypal/complete"
  post "schedule_comments/delete_schedule_comment"

  get "top/get_schedule_list"
  get "top/get_schedule_apply_list"
  get "top/get_schedule_history_list"

  resources :users
  resources :courses
  resources :lessons
  resources :schedules
  resources :guests
  resources :comments
  resources :schedule_comments

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
  # match ':controller(/:action(/:id))(.:format)'
end
