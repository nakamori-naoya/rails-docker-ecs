Rails.application.routes.draw do
  get 'users/api/v1'
  post 'user_token' => 'user_token#create'
  namespace :api do
    namespace :v1 do
        resources :tasks, only: :index
        get :health_check, to: 'health_check#index'
        post 'user_token' => 'user_token#create'
        resources :users, only: [:index, :create] 
    end
  end
end
