Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'static_pages/home'
  root 'static_pages#home'
  resources :parties do
    resources :invitations
  end



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
