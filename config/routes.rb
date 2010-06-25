ActionController::Routing::Routes.draw do |map|
  map.with_options :controller => 'general' do |general|
    general.root(:action => :index)
    general.connect('help', :action => :help)
  end

  map.with_options :controller => 'session' do |session|
    session.logout 'logout', :action => 'destroy'
    session.login 'login',   :action => 'new', :conditions => {:method => :get}
    session.connect 'login',   :action => 'create', :conditions => {:method => :post}
  end

  map.resource :account, :controller => :account do |account|
    account.resources :notes do |note|
      note.delete 'delete', :action => :delete, :controller => :notes
    end
  end

  map.signup 'signup' , :controller => 'account', :action => 'new', :conditions => {:method => :get}
  map.connect 'signup', :controller => 'account', :action => 'create', :conditions => {:method => :post}
  map.create_user 'signup', :controller => 'user', :action => 'create', :conditions => {:method => :post}

  map.resources :users, :controller => :user do |user|
  end

  map.resources :notes, :controller => 'public_notes' do |note|
    note.resources 'comments', :controller => 'note_comments', :only => [:create]
    note.resources 'citations', :controller => 'note_citations', :only => [:create, :new]
  end
end
