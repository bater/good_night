Rails.application.routes.draw do
  scope 'user/:id' do
    get "follow/:friend_id", to: "user#follow"
    get "unfollow/:friend_id", to: "user#unfollow"
    get "go_to_bed", to: "user#go_to_bed"
    get "wake_up", to: "user#wake_up"
    get "sleeps", to: "user#sleeps"
  end
end
