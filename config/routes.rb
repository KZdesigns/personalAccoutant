Rails.application.routes.draw do


  root "pages#home"
  get "/gl_accounts", to: "gl_accounts#index"
  get "/transactions", to: "transactions#index"

  resources :gl_accounts

  resources :transactions do 
    collection { post :import }
    collection { get :income }
    collection {get :expense }
  end

end
