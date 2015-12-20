class PostController < ApplicationController
	
	include UserHelper

	def show_posts
		@page_title = "Posts"
	end

	def create_post
		redirect_to "/" unless is_logged_in?
		@page_title = "New Post"
	end

	def create_post_handler
		post = current_user.posts.new(title:params[:title],content:params[:content],upvotes:0)
		post.save
		redirect_to "/"
	end
end
