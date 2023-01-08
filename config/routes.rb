Rails.application.routes.draw do
  resources :user, only: [] do
    get "follow/:friend_id", to: "user#follow"
    get "unfollow/:friend_id", to: "user#unfollow"
    get :go_to_bed, :wake_up, :sleeps, :friends
  end
end
