MediNet::Application.routes.draw do
  match "profil/:id/:slug" => 'profil#show',  :as => "profil"
  match "profil/edit" => 'profil#edit',       :as => "edit_profil"
  match "profil/auth" => 'profil#auth',       :as => "auth_profil"
  match "profil/import" => 'profil#import',   :as => "import_profil"
  
  root :to => 'welcome#index'
  
  namespace :admin do
    resources :users
  end
end
