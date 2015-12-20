class User < ActiveRecord::Base
  
  attr_accessible :email, :name, :password, :password_confirmation
  
  has_secure_password
  has_many :posts
  
  validates :email, presence:true, format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
  validates :name, presence:true, length:{within:6..32}
  validates :password, presence:true, length:{within:8..32}, confirmation:true

end
