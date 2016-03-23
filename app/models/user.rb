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
end
