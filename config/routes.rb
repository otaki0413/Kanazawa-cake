Rails.application.routes.draw do

  get '/admin' => 'admin/homes#top'

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  # URLは指定のパスにしたい,ファイル構成も指定のパスにしたい→namespace
  namespace :admin do
    resources :products
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end
  # devise_for :admin, skip: :all
  # devise_scope :admin do
  #   get 'admin/sign_in' => 'admin/sessions#new'
  #   post 'admin/sign_in' => 'admin/sessions#create'
  #   delete 'admin/sign_out' => 'admin/sessions#destroy'
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
