Rails.application.routes.draw do

  # namespace :member do
  #   get 'delivery_goals/index'
  #   get 'delivery_goals/create'
  #   get 'delivery_goals/edit'
  #   get 'delivery_goals/update'
  #   get 'delivery_goals/destroy'
  # end
  # namespace :member do
  #   get 'orders/index'
  #   get 'orders/new'
  #   get 'orders/show'
  #   get 'orders/create'
  #   get 'orders/confirm'
  #   get 'orders/thanks'
  # end
  # namespace :member do
  #   get 'cart_items/index'
  #   get 'cart_items/update'
  #   get 'cart_items/destroy'
  #   get 'cart_items/all_destroy'
  # end
  # namespace :admin do
  #   get 'members/index'
  #   get 'members/show'
  #   get 'members/edit'
  #   get 'members/update'
  # end
  # namespace :member do
  #   get 'members/index'
  #   get 'members/edit'
  #   get 'members/update'
  #   get 'members/unsubscribe'
  #   get 'members/retire'
  # end

  # namespace :member do
  #   get 'products/index'
  #   get 'products/show'
  # end

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }

  devise_for :members, controllers: {
    sessions: 'member/sessions',
    registrations: 'member/registrations',
  }

  get '/admin' => 'admin/homes#top'

  # member/homesコントローラのルーティング
  root 'member/homes#top'
  get '/about' => 'member/homes#about'

  # member/membersコントローラのルーティング
  get '/member' => 'member/members#index'
  get '/member/edit' => 'member/members#edit'
  patch '/member' => 'member/members#update', as: "members"
  get '/member/unsubscribe' => 'member/members#unsubscribe'
  patch '/member/retire' => 'member/members#retire'

  # member/cart_itemsコントローラの追加ルーティング
  delete '/cart_items' => 'mamber/cart_items#all_destroy'

  # member/ordersコントローラの追加ルーティング
  post '/orders/confirm' => 'member/orders#confirm'
  get '/orders/thanks' => 'member/orders#thanks'


  scope module: :member do
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy]
    resources :orders, only: [:index, :create, :show, :new]
    resources :delivery_goals, only: [:index, :create, :edit, :update, :destroy]
  end


  # URLは指定のパスにしたい,ファイル構成も指定のパスにしたい→namespace
  namespace :admin do
    resources :products
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :members, only: [:index, :show, :edit, :update]
  end



end
