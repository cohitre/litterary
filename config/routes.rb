Litterary::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/login" => "devise/sessions#new", as: :login
  end

  root to: 'general#index'
  get 'help' => 'general#help'

#  delete 'logout' => 'session#destroy', as: :logout
#  get  'login' => 'session#new', as: :login
#  post 'login' => 'session#create'

#  get '/signup' => 'account#new', as: :signup
#  post '/signup' => 'account#create'

  resource :account, controller: 'account' do
    resources :notes do
      delete 'delete' => 'notes#delete'
    end
  end

  resources :users, controller: "user"
  resources :notes do
    resources :comments, :only => [:create]
    resources :citations, :only => [:create, :new]
  end
end
