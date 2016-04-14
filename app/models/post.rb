class Post < ActiveRecord::Base
  belongs_to :user

  #Add search methods to the model: 2 types when user searches - 1) self.search_posts(arg)
  #2) self.search_users(arg)

  #1) Call the class & search all posts that contain 'arg' value (input from search form)
  #in the post 'title', 'content' & 'htag' fields.
  def self.search_posts(arg)
    user = User.find_by(username: arg)
    if user #Check if value inputted is the username of a 'user', if so, return all posts of that 'user' related to search input.
      posts = user.posts + Post.where('(hatgs LIKE ?) OR (content LIKE ?) OR (content LIKE ?)', "%#{arg}", "%#{arg}", "%#{arg}")
    else #return all posts related to search input
      posts = Post.where('(hatgs LIKE ?) OR (content LIKE ?) OR (content LIKE ?)', "%#{arg}", "%#{arg}", "%#{arg}")
    end
    return posts.uniq #Make sure we don't return duplicated posts
  end
  #2 return all posts of a given user. This time the 'arg' value corresponds to a 'user_id' instead
  #of a search term. This method will be used on front-end to display the correct posts on a users
  #profile page.
  def self.search_users(arg)
    posts = Post.where("user_id = :id", {id: arg})
  end
end
