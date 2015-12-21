require 'open-uri'

class Post < ActiveRecord::Base
  
  attr_accessible :url, :title, :upvotes, :user_id
  belongs_to :user
  before_save :get_header

  validates :url, presence:true, format:{ with:/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, message:"invalid URL please provide a complete URL with http/https scheme"}

  def get_header
  	doc = Nokogiri::HTML(open(self.url))
  	self.title = doc.css("title").inner_html
  end

end
