resources :projects do
  resources :gollum, constraints: {id: /.*/}
  resource  :gollum_wiki
end
