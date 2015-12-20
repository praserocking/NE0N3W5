module UserHelper
	def is_logged_in?
		!session[:id].nil?
	end

	def login_user(email,name,id)
		session[:email] = email
		session[:name] = name
		session[:id] = id
	end

	def logout_user
		session[:email] = nil
		session[:name] = nil
		session[:id] = nil
	end
end
