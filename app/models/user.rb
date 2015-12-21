class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  has_secure_password
  
  has_many :posts
  has_many :likes
  
  validates :email, presence:true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :name, presence:true, length:{within:6..32} , format: {with: /^[a-zA-Z0-9_]*$/, message:"can contain alphabets, numbers and underscores only"}
  validates :password, presence:true, length:{within:8..32}, confirmation:true

end
