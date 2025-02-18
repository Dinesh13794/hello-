Rails.application.routes.draw do
  get "home/index"
  namespace :api do
    resources :tasks, only: [:index, :create, :update, :destroy, :show]
    namespace :auth do
      post 'register', to: 'auth#register'
      post 'login', to: 'auth#login'
      delete 'logout', to: 'auth#logout'
    end
  end

  
  get '*path', to: 'home#index', constraints: ->(req) do
    !req.xhr? && req.format.html?
  end
end
