Rails.application.routes.draw do
  get '/auth/slack/callback' => 'session#slack_callback'

  root 'pages#index'
  get '/wip_term' => 'pre_built_pages#wip_term'
  get '/thesis' => 'pre_built_pages#thesis'
  get '/newcomer' => 'pre_built_pages#newcomer'

  resources :users, only: [:index, :update]
  resources :groups, only: [:index, :create]
  resources :meetings, only: [:index, :show, :new, :create], shallow: true do
    resources :presentations, only: [:new, :create]
  end
  resources :uploads, only: [:index, :create, :show]

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
    get '/' => redirect('/')
    scope '/*path' do
      get '/edit' => 'pages#edit', as: :edit_page
      get '/rename' => 'pages#rename', as: :rename_page
      resources :histories, as: :page_histories, controller: :page_histories, only: [:index, :show] do
        member do
          get :diff
        end
      end
      get '/' => 'pages#show', as: :page
      patch '/' => 'pages#update', as: :update_page
    end
  end

  resources :comments, only: :create
  resources :likes, only: [:create, :destroy]

  namespace :api do
    namespace :v1, format: :json do
      resources :attendances
    end
  end
end
