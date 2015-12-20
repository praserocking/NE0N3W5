class Post < ActiveRecord::Base
  attr_accessible :content, :title, :upvotes, :user_id
  belongs_to :user
end
