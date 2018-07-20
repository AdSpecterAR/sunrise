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
end
