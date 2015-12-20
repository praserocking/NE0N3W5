class UserController < ApplicationController
	def signup
		@page_title = "SignUp"
	end

	def signup_handler
		new_user = User.new(name:params[:name], email:params[:email], password:params[:password], password_confirmation:params[:password_confirmation])
		if new_user.save
			flash[:success] = "User Successfully created with email #{new_user.email}"
			render "signup"
		else
			@errors = new_user.errors
			@page_title = "SignUp"
			render "signup"
		end
	end

	def login
		@page_title = "Login"
	end

	def login_handler
		logged_in_user = User.where(email:params[:email]).first

		if !logged_in_user.blank? and logged_in_user.authenticate(params[:password])
			flash[:success] = "User Logged in"
			render "login"
		else
			@errors = ["Email or Password is wrong"]
			@page_title = "Login"
			render "login"
		end
	end
end
