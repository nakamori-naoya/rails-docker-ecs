Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get :health_check, to: 'health_check#index'
      post 'user_token' => 'user_token#create'
      resources :users do
        resource :profile
      end
      resources :portfolios do
        resources :evals
        resources :chats
        resource :avg_evals
      end
    end
  end
end
