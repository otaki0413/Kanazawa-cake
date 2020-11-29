Rails.application.routes.draw do

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

  # member/productsコントローラのルーティング
  scope module: :member do
    resources :products, only: [:index, :show]
  end

  # URLは指定のパスにしたい,ファイル構成も指定のパスにしたい→namespace
  namespace :admin do
    resources :products
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end



end
