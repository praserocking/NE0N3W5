class UserController < ApplicationController
	include UserHelper

	def signup
		redirect_to "/" if is_logged_in?
		@page_title = "SignUp"
	end

	def signup_handler
		redirect_to "/" if is_logged_in?
		new_user = User.new(name:params[:name], email:params[:email], password:params[:password], password_confirmation:params[:password_confirmation])
		if new_user.save
			flash[:success] = "User Successfully created with email #{new_user.email}"
			login_user(new_user.name,new_user.email,new_user.id)
			redirect_to "/"
		else
			@errors = new_user.errors
			@page_title = "SignUp"
			render "signup"
		end
	end

	def login
		redirect_to "/" if is_logged_in?
		@page_title = "Login"
	end

	def login_handler
		redirect_to "/" if is_logged_in?
		logged_in_user = User.where(email:params[:email]).first

		if !logged_in_user.blank? and logged_in_user.authenticate(params[:password])
			flash[:success] = "User Logged in"
			login_user(logged_in_user.name,logged_in_user.email,logged_in_user.id)
			redirect_to "/"
		else
			@errors = ["Email or Password is wrong"]
			@page_title = "Login"
			render "login"
		end
	end

	def logout_handler
		logout_user
		redirect_to "/login"
	end
end
