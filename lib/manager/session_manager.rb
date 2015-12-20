
	class SessionManager

		def self.login_user(name,email,id,session)
			@session[:name] = name
			@session[:email] = email
			@session[:id] = id
		end

		def self.is_logged_in?(session)
			!@session[:id].blank?
		end

		def self.logout_user(session)
			@session[:name] = nil
			@session[:email] = nil
			@session[:id] = nil
		end

		def self.name(session)
			@session[:name]
		end

	end