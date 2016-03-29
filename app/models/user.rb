class User < ActiveRecord::Base
  
  #Allow users to follow and be followed using act_as_follower gem
  acts_as_followable
  acts_as_follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates_presence_of :username
  validates_uniqueness_of :username

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         :token_authenticatable

  has_many :authentication_tokens
  #When a user gets deleted, their posts are also deleted
  has_many :posts, :dependent => :destroy

  #Create custom method called followed_users_posts - responsible for 
  #returning all posts from users that we follow
  def followed_users_posts
    #1 First find all users that I follow with the "self.following" method
    users = self.all_following

    #2 Now initialize an array called my_posts
    my_posts = Array.new

    #3 Iterate over each user I follow, fetch all their posts
    #  and add them to the my_posts array.
    users.each do |u|
      u.posts.each do |p|
        my_posts.push(p)
      end
    end

    #4 Then add all of my posts to the same my_posts array.
    self.posts.each do |p|
      my_posts.push(p)
    end
    #5 Return my_posts array
    return my_posts
  end #End followed_users_posts

end
