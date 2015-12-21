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

	def current_user
		User.find(session[:id])
	end

	def get_user_name(id)
		User.find(id).name
	end

	def current_user_liked?(post_id)
		!current_user.likes.select{|like| like.post_id == post_id}.empty?
	end
end
