require 'open-uri'
require 'openssl'
require 'open_uri_redirections'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Post < ActiveRecord::Base
  
  attr_accessible :url, :title, :upvotes, :user_id
  
  belongs_to :user
  has_many :likes

  before_save :get_header

  validates :url, presence:true, format:{ with:/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, message:"invalid URL please provide a complete URL with http/https scheme"}

  def get_header
  	doc = Nokogiri::HTML(open(self.url, :allow_redirections => :all))
  	puts doc.url
  	puts "* "*50
  	self.title = doc.css("title").inner_html
  end
  
end
