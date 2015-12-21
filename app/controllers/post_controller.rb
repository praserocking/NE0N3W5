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
		redirect_to "/" unless is_logged_in?
		post = current_user.posts.new(url:params[:url],upvotes:0)
		if post.save
			redirect_to "/"
		else
			@errors = post.errors
			render "create_post"
		end
	end

	def like_post
		redirect_path = nil
		
		if not is_logged_in?
			flash[:success] = "You need to login for Upvoting!"
			redirect_path = "/login"
		else
			user_id = current_user.id
			post = Post.find(params[:id])
			
			if current_user.likes.select{|like| like.post_id == post.id}.empty?
				post.likes.create(user_id:user_id).save
				post.update_attribute(:upvotes, post.upvotes + 1)
			end
			
			redirect_path = :back
		end

		redirect_to redirect_path
	end
end
