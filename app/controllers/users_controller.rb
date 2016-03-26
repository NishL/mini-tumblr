#UsersController inherits from the ApplicationController class
class UsersController < ApplicationController
  #Make sure only authenticated users can access actions in this controller, use Devise "before_action"
  #Except for the three methods which we want to grant public access to: 1) :show_user_profile 2) :followers 3) :following
  before_action :authenticate_user!, :except => [:show_user_profile,:followers, :following]

  #Return the current_user to store and access in front end app
  def my_current_user
    render json: current_user
  end

  #Return random_users to show all other users we can follow in random order
  #the method current_user.all_following is part of act_as_follower's gem methods and returns all user that curren_user is following
  def random_users
    @users = User.where.not(id: current_user.id) - current_user.all_following
    render json: @users.sample(5) #this method fetches 5 random users from @users
  end

  #This action "show_current_user_profile" is responsible for returning the current_user based on the parameter :id sent with the request
  #This action will be called from the AngularJS app to show the current_user's profile page.
  def show_current_user_profile
    @user = User.find(params[:id])
    render json: @user
  end

  #This action "show_user_profile" is responsible for retrieving data for each user from database. App allows non-registered users to search
  #for other user profiles, therefore, action must be accessible to everyone. Action wil return a user according to the :username param passed 
  #on by the request.
  def show_user_profile
    @user = User.find(username: params[:username])
    render json: @user
  end

  #Create follow action - find the followed user through :user_id param passed by the request
  #make the current_user follow that person we want to follow by calling the act_as_follwer gem method -> .follow(user)
  def follow
    user = User.find(params[:user_id])
    @follow = current_user.follow(user)
    render json: @follow
  end

  #Create unfollow action - find the followed user through :user_id passed by request
  #make current_user unfollow that user by calling act_as_follower's method - .stop_following(user)
  def unfollow
    user = User.find(params[:user_id])
    @unfollow = current_user.stop_following(user)
    render json: @unfollow
  end

  #Create action for followers to return the number of followers of a given user
  #Find the user through the :id param passed by the request and get that user's followers
  #by calling the act_as_follower method - .followers
  def follower
    @users = User.find(params[:id]).followers
    render json: @users
  end

  #Create action for following to return the number of followers of a given user.
  #Find the user through the :id parameter passed by the request, then get that users
  #followers by calling the act_as_follower gem method - .all_following
  def following
    @users = User.find(params[:id]).all_following
    render json: @users
  end

  #Create action for is_following - responsible for checking if a given user is followed by curren_user
  #Find the user through :user_id param passed by the request and check if that user is followed by current_user
  #by calling the act_as_follower method - .followed_by?(user)
  def is_following
    @user = User.find(params[:user_id]).followed_by?(curren_user)
    render json: @user
  end

  #Create update_user action for front end app.
  #Find user though :id param passed by request, and if found call a private method "update(user_params)"
  def update_user
    @user = User.find(params[:id])
      if @user.update(user_params)
        head :no_content
      else
        render json: @user.errors, status :unprocessable_entity
      end
  end

  #Create private method user_params, responsible for whitelisting specific parameters for mass assignment
  private

  def user_params
    params.require(:user).permit(:username, :avatar, :password)
  end

end