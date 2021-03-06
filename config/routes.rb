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

  root "course_sessions#upcoming_courses"
  post "/register_new_user" => "users#create", as: :create
  get "/fetch_user/:firebase_uid" => "users#index"

  get "/upcoming_courses" => "course_sessions#upcoming_courses"
  get "/users/:user_id/course_sessions/:course_session_id" => "user_course_sessions#get_user_course_session",
      as: :get_user_course_session

  post "/user_course_sessions/:user_course_session_id/feedback/" => "user_course_sessions#post_feedback",
       as: :post_feedback

  post "/subscribe" => "charges#subscribe"
  post "/cancel_subscription" => "charges#cancel_subscription"

  get "/course_sessions/:course_session_id/users" => "course_sessions#get_students",
      as: :get_students


  ### POSTURE APP ###

  get "/courses" => "posture_courses#index"
  get "/courses/grouped_by_category" => "posture_courses#grouped_by_category"

  # put "/viewed_track/:id"
  # put "/viewed_posture_course/:id"

  # put "/completed_track/:id"
  # put "/completed_posture_course/:id"

  get "/all_tracks" => "tracks#all"

  # get favorite classes
  # get recent classes

  get "/users/:user_id/favorite_courses" => "users#favorite_course"
  get "/users/:user_id/recent_courses" => "users#recent_courses"

  post "/users/:user_id/favorite_course" => "users#favorite_course"
  post "/users/:user_id/unfavorite_course" => "users#unfavorite_course"
  post "/users/:user_id/finish_onboarding" => "users#finish_onboarding"
  post "/users/:user_id/select_track" => "users#select_track"
  post "/users/:user_id/viewed_course/:course_id" => "users#viewed_course"
  post "/users/:user_id/viewed_course/:course_id/complete" => "users#complete_course"
end
