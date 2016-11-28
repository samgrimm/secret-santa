Rails.application.routes.draw do

  resources :wishlists do
    resources :items
  end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'static_pages/home'
  root 'static_pages#home'
  resources :parties do
    resources :invitations
  end

  get "/contacts/:importer/callback" => "invitations#callback"

  get "/contacts/failure" => "invitations#failure"

  get '/draw_names/:id' => "parties#draw_names", as: :draw_names

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
