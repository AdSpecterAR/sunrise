Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # post 'user_token' => 'user_token#create'

  ### AUTHENTICATION ###

  resources :sessions, only: [:create, :destroy]

  ### USERS ###

  post "/users" => "users#create"

  get "/upcoming_courses" => "course_sessions#upcoming_courses"
  get "/users/:user_id/course_session/:course_session_id" => "user_course_sessions#get_user_course_session",
      as: :get_user_course_session

  post "/user_course_session/:user_course_session_id/feedback" => "user_course_sessions#post_feedback",
       as: :post_feedback

end
