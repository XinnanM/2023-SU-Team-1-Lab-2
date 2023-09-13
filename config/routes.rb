Rails.application.routes.draw do
  resources :recommendations
  resources :sections
  resources :courses
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :grader_applications
  resources :permission_requests
  resources :inbox_applications

  put 'inbox_applications/approve'
  put 'inbox_applications/deny'
  put 'permission_requests/approve'
  put 'permission_requests/deny'

  get 'course_fetcher_ui/index'
  post 'course_fetcher_ui/fetch_courses'
  
  #commenting the default home index thing out. This is to have a landing page.
  #get 'home/index'
  root 'home#index'

  # Defines the root path route ("/")
  # root "articles#index"
end
