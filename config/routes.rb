Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # post 'user_token' => 'user_token#create'

  ### AUTHENTICATION ###

  resources :sessions, only: [:create, :destroy]
  resources :users
  resources :charges

  ### USERS ###

  post "/register_new_user" => "users#create", as: :create

  post "/facebook_authentication" => "users#facebook_authentication", as: :facebook_authentication

  get "/upcoming_courses" => "course_sessions#upcoming_courses"
  get "/users/:user_id/course_sessions/:course_session_id" => "user_course_sessions#get_user_course_session",
      as: :get_user_course_session

  post "/user_course_sessions/:user_course_session_id/feedback/" => "user_course_sessions#post_feedback",
       as: :post_feedback
  
end
