require 'open-uri'
require 'openssl'
require 'open_uri_redirections'
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

class Post < ActiveRecord::Base
  
  attr_accessible :url, :title, :upvotes, :user_id
  
  belongs_to :user
  has_many :likes

  before_validation :get_header

  validates :url, presence:true, format:{ with:/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/, message:"invalid URL please provide a complete URL with http/https scheme"}

  def get_header
    begin
  	    doc = Nokogiri::HTML(open(self.url, :allow_redirections => :all))
  	    self.title = doc.css("title").inner_html
        raise InvalidUrlException if self.title.blank?
    rescue
        errors.add(:URL_Error, ': Cannot fetch title from URL. Please Check the URL entered.')
        false
    end
  end
  
end
