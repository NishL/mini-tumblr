class Post < ActiveRecord::Base
  belongs_to :user

  #Add search methods to the model: 2 types when user searches - 1) self.search_posts(arg)
  #2) self.search_users(arg)
end
