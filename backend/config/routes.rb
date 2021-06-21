Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      get :health_check, to: 'health_check#index'
      post 'user_token' => 'user_token#create'
      resources :users do
        collection do
          post 'search'
        end
        resource :profile do 
        end
      end
      resources :portfolios do
        collection do
          post 'search'
        end
        resources :evals
        resources :chats
        resource :avg_evals
      end

      resources :categories do
        collection do
          post 'search'
        end
      end

    end
  end
end
