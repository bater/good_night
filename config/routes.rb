Rails.application.routes.draw do
  scope 'user/:id' do
    get "follow/:friend_id", to: "user#follow"
    get "unfollow/:friend_id", to: "user#unfollow"
  end
end
