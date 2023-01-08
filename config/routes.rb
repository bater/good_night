Rails.application.routes.draw do
  get "user/:id/follow/:friend_id", to: "user#follow"
  get "user/:id/unfollow/:friend_id", to: "user#unfollow"
end
