class PostController < ApplicationController
	
	include UserHelper

	def show_posts
		@page_title = "Posts"
		@posts = Post.order("created_at DESC")
	end

	def create_post
		redirect_to "/" unless is_logged_in?
		@page_title = "New Post"
	end

	def create_post_handler
		post = current_user.posts.new(url:params[:url],upvotes:0)
		if post.save
			redirect_to "/"
		else
			@errors = post.errors
			render "create_post"
		end
	end
end
