Rails.application.routes.draw do
  get '/auth/slack/callback' => 'session#slack_callback'

  root 'pages#index'
  get '/wip_term' => 'pre_built_pages#wip_term'
  get '/thesis' => 'pre_built_pages#thesis'
  get '/newcomer' => 'pre_built_pages#newcomer'

  resources :users, only: [:index, :update]
  resources :groups, only: [:index, :create]
  resources :privileges, only: [:new, :create]
  resources :meetings, except: :destroy, shallow: true do
    resources :presentations, except: :index, shallow: true do
      resources :user_judgments, only: [:index, :create, :destroy]
    end
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

  # resources :blogs, type: 'Blog', param: :nickname, only: :new do
  #   collection do
  #     get '/:nickname' => 'blogs#index'
  #     post '/:nickname' => 'blogs#create'
  #   end
  #
  #   member do
  #     scope '/:timestamp', constraints: { timestamp: /\d/ } do
  #       get '/' => 'blogs#show'
  #       patch '/' => 'blogs#update'
  #       get '/edit' => 'blogs#edit', as: :edit
  #     end
  #   end
  # end

    # resources :blog_articles, type: 'Blog', param: :timestamp, path: '' do
    # end
  # scope :blogs do
  #   resources :blogs, type: 'Blog', param: :timestamp, path: '' do
  #   end
  # end

  # scope :blogs do
    # get '/' => redirect('/')
    # get '/new' => 'blogs#new', as: :new_blog
    # scope '/:nickname' do
      # get '/' => 'blogs#index', as: :blogs
      # get '/:timestamp' => 'blogs#show', as: :blog
      # get '/:timestamp/edit' => 'blogs#edit', as: :edit_blog
      # post '/:timestamp' => 'blogs#update', as: :update_blog
    # end
  # end

  namespace :api do
    namespace :v1, format: :json do
      resources :attendances
    end
  end
end
