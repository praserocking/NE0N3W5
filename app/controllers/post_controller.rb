class PostController < ApplicationController
	
	include UserHelper

	POSTS_PER_PAGE = 5

	def show_posts
		@page_title = "Posts"
		@blank_state = false

		count = Post.count
		
		@blank_state = true if count == 0

		@pages = (count/POSTS_PER_PAGE) + 1 unless count%POSTS_PER_PAGE == 0
		@pages = (count/POSTS_PER_PAGE) if count%POSTS_PER_PAGE == 0

		if params[:pageno].blank?
			@posts = Post.order("created_at DESC").limit(POSTS_PER_PAGE)
			@selected_page = 1
		else
			page_no = params[:pageno].to_i
			@posts = Post.order("created_at DESC").offset(POSTS_PER_PAGE * (page_no - 1)).limit(POSTS_PER_PAGE)
			@selected_page = page_no
		end
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
