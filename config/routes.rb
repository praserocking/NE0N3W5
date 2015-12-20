Neonews::Application.routes.draw do
  get "/signup" => "User#signup"
  post "/signup"=> "User#signup_handler"
end
