Neonews::Application.routes.draw do
  get "/signup" => "User#signup"
  post "/signup"=> "User#signup_handler"

  get "/login" => "User#login"
  post "/login"=> "User#login_handler"

  get "/logout" => "User#logout_handler"

  get "/" => "Post#show_posts"
end
