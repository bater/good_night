Rails.application.routes.draw do
  get "user/:id/follow/:friend_id", to: "user#follow"
end
