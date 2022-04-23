Rails.application.routes.draw do
  root "pages#home"
  get "/gl_accounts", to: "gl_accounts#index"

  resources :gl_accounts 

end
