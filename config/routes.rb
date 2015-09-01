Rails.application.routes.draw do
  get '/auth/slack/callback' => 'session#slack_callback'

  root 'pages#index'
  scope :pages do
    get   '*path/edit' => 'pages#edit', as: :edit_page
    patch '*path' => 'pages#update', as: :update_page
    get   '*path' => 'pages#show', as: :page
  end

  resources :comments, only: :create
  resources :likes, only: [:create, :destroy]
  scope :search do
    get '/' => 'search#index'
    get '*keyword' => 'search#show', as: :search
  end
end
