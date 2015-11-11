resources :projects do
  resources :gollum, constraints: {id: /.*/}, :as => 'gollum' do
    member do
      match 'preview', :via => [:post, :put]
    end
  end
  resource :gollum_wiki
end
