Rails.application.routes.draw do
  get '/auth/slack/callback' => 'session#slack_callback'

  root 'pre_built_pages#top'
  get '/wip_term' => 'pre_built_pages#wip_term'
  get '/thesis' => 'pre_built_pages#thesis'

  resources :groups, only: [:index, :create]
  resources :meetings, only: [:index, :create]

  scope :settings do
    get '/profile' => 'settings#edit_profile', as: :edit_profile
    patch '/profile' => 'settings#update_profile', as: :update_profile
    patch '/profile/ldap' => 'settings#update_ldap', as: :update_ldap
  end

  scope :search do
    get '/' => 'search#index'
    get '/*keyword' => 'search#show', as: :search
  end

  scope :pages do
    get '/' => 'pages#index', as: :pages
    get '/*path/edit' => 'pages#edit', as: :edit_page
    patch '/*path' => 'pages#update', as: :update_page
    get '/*path' => 'pages#show', as: :page
  end

  resources :comments, only: :create
  resources :likes, only: [:create, :destroy]
end
