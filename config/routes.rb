Rails.application.routes.draw do
  resources :posts do
    member do
      put "like" => "posts#upvote"
      put "dislike" => "posts#downvote"
    end
  end
  resources :likes, only: [ :create, :destroy] do
    member do
      post :find_likeable
    end
  end
 
  resources :comments 

  devise_for :users
  get 'home/front'
  post 'home/follow'
  get 'home/unfollow'
  post 'home/unfollow'
  get 'home/index'
  get 'home/find_friends'
  root to: 'home#index'
  
  get 'follows/follow_friends'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
