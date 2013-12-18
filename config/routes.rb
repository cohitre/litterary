Litterary::Application.routes.draw do
  devise_for :users, :path => '/', :path_names => {
    :sign_in => 'login',
    :sign_up => 'join',
    :sign_out => 'logout',
    :password => 'secret',
    :confirmation => 'verification'
  }

  root to: 'general#index'

  resource :account, controller: 'account', only: [:show, :edit, :update]
  resources :users, controller: "user", only: [:index, :show]
  resources :notes do
    resources :comments, :only => [:create]
    resources :citations, :only => [:create, :new]
  end
end
