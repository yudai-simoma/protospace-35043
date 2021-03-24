Rails.application.routes.draw do
  #新規登録のdevise呼ぶ時のコード
  devise_for :users
  #トップページを表示させるコード
  root to: 'prototypes#index'
  #投稿機能に必要なアクション
  resources :prototypes, only: [:new, :create, :show, :edit, :update, :destroy]
  #コメント機能に必要なアクション
  resources :prototypes do
    resources :comments, only: :create
  end
  #ユーザー詳細情報に必要なアクション
  resources :users, only: :show
end
