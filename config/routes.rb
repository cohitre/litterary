Litterary::Application.routes.draw do
  devise_for :users, :path => '/', :path_names => {
    :sign_in => 'login',
    :sign_up => 'join',
    :sign_out => 'logout',
    :password => 'secret',
    :confirmation => 'verification'
  }

  root to: 'general#index'

  get "/weeks/draft" => "notes#edit", as: :draft
  get "/weeks" => "weeks#index", as: :weeks
  get "/weeks/:id" => "weeks#show", as: :week

  resource :account, controller: 'account', only: [:show, :edit, :update]
  resources :users, controller: "user", only: [:show]
  resources :notes do
    resources :comments, :only => [:create]
    resources :citations, :only => [:create, :new]
  end

  get "/api/v1/notes/:note_id" => "api/v1/notes#show"
  post "/api/v1/notes/:note_id/citations" => "note_citations#create"
#  get "/api/v1/notes/:note_id/citations" => "NoteCitations#index"
end
