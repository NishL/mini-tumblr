Rails.application.routes.draw do
  #Tell Devise to use our registrations controller instead of the default
  devise_for :users, :controllers => { :sessions => "sessions", :registrations => "registrations" }

  #Add proper route for my_current_user - get to action by calling localhost:3000/my_current_user.json
  match '/my_current_user' => 'users#my_current_user', via: [:get]

  #Add route to return random_users by calling localhost:3000/random_users.json
  match '/random_users' => 'users#random_users', via: [:get]

  #Add route to return show_current_user_profile (the user profile) by calling localhost:3000/users/[id].json
  match '/users/:id' => 'users#show_current_user_profile', via: [:get]

  #Add route for show_user_profile
  match '/users/profile/:username' => 'users#show_user_profile', via: [:get]

  #Add route for update_user action. Start action by calling localhost:3000/users/:id.json
  match 'users/:id' => 'users#update_user', via: [:patch]

  #Create route for follow action. Start the action by calling localhost:3000/follow.json?user_id=[id]
  get '/follow' => "users#follow"

  #Create route for unfollow action. Start action by calling localhost:3000/unfollow.json?user_id=[id]
  get '/unfollow' => "users#unfollow"

  #Create route for followers action. Start action by calling localhost:3000/followers/[id].json
  get '/followers/:id' => "users#followers"

  #Create route for following action. Start action by calling localhost:3000/following/[id].json
  get '/following/:id' => "users#following"

  #Create route for is_following aciton. Access action by calling localhost:3000/users/:user_id/is_following.json
  get 'users/:user_id/is_following' => "users#is_following"


end
