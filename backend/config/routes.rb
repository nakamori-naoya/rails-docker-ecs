Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get :health_check, to: 'health_check#index'
      post 'user_token' => 'user_token#create'
      resources :users 
      resources :portfolios do
        resources :evals
        resources :chats
      end
    end
  end
end
