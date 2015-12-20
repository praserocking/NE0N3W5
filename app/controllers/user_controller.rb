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
end
