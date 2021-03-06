Rails.application.routes.draw do
  get 'notifications/:id/link_through', to: "notifications#link_through", as: :link_through
  get 'notifications', to: "notifications#index"

  get 'profiles/show'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :pictures do
  	resources :comments
  		member do
  			get 'like'
        get 'unlike'
  		end
  end
  root 'pictures#index'
  get ':username', to: 'profiles#show', as: :profile
  get ':username/edit', to: 'profiles#edit', as: :edit_profile
  patch ':username/edit', to: 'profiles#update', as: :update_profile
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
