Rails.application.routes.draw do
  get '/auth/slack/callback' => 'session#slack_callback'

  root 'pages#index'
  get '/wip_term' => 'pre_built_pages#wip_term'
  get '/thesis' => 'pre_built_pages#thesis'
  get '/newcomer' => 'pre_built_pages#newcomer'

  resources :users, only: [:index, :update]
  resources :groups, only: [:index, :create]
  resources :privileges, only: [:index, :new, :create]
  resources :api_keys, only: [:index, :create, :destroy]
  resources :meetings, shallow: true do
    resources :presentation_orders, only: [:index, :create]
    resources :user_judgements, only: :index
    resources :presentations, except: :index, shallow: true do
      resources :user_judgements, only: [:create, :destroy]
    end
  end
  resources :uploads, only: [:index, :create, :show] do
    member do
      get '/*filename' => 'uploads#file', as: :file
    end
  end

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

  resources :page_comments, type: 'PageComment', only: :create
  resources :presentation_comments, type: 'PresentationComment', only: [:index, :create]
  resources :blog_comments, only: :create
  resources :likes, only: [:create, :destroy]

  scope :blogs do
    get '/' => redirect('/'), as: :blogs
    post '/' => 'blogs#create'
    get '/new' => 'blogs#new', as: :new_blog
    scope '/:nickname' do
      get '/' => 'blogs#index', as: :list_blog
      scope '/:timestamp', constraints: { timestamp: /\d+/ } do
        get '/' => 'blogs#show', as: :blog
        patch '/' => 'blogs#update'
        get '/edit' => 'blogs#edit', as: :edit_blog
      end
    end
  end

  get '/line/associate' => 'line_integration#associate', as: :associate_line
  post '/line/associate' => 'line_integration#do_associate'
  post '/line/callback' => 'line_integration#callback', as: :callback_line

  namespace :api do
    namespace :v1, format: :json do
      resources :attendances, only: :create
    end
  end
end
