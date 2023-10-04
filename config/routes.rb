Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  get 'member/:id', to: 'members#show', as: 'member'
  get 'edit_description', to: 'members#edit_description', as: 'edit_memeber_description' 
  patch 'update_description', to: 'members#update_description', as: 'update_member_description'
  get 'edit_profile', to: 'members#edit_profile', as: 'edit_profile'
  patch 'update_profile', to: 'members#update_profile', as: 'update_profile'
  
  resources :work_experiences

end
