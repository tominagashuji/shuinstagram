Rails.application.routes.draw do
  get 'sessions/new'

  ##  朱印スタグラム：起動時にトップ画面が表示されるようにする
  root 'tops#index'

  ##  ログインシステム
  resources :users

  resources :pictures do
    collection do
      post :confirm
    end
  end

  resources :tops
  resources :sessions
  resources :favorites, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
