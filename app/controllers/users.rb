
require 'httparty'
require 'json'


address = "http://recruiting-api.nextcapital.com/users"

post '/register' do

  @output = HTTParty.post(address,
      :query => {  email: params[:email],
                   password: params[:password]  })

  @api_response = JSON.parse(@output.body)

  display_results_in_terminal

  if @output.code == 200
    give_token
  else
    @message = @output.message
  end

  erb :index
end


post '/login' do

  extension = "/sign_in"

  @output = HTTParty.post(address + extension,
      :query => {  email: params[:email],
                   password: params[:password]  })

  @api_response = JSON.parse(@output.body)

  display_results_in_terminal

  if @output.code == 200
    give_token
  else
    @message = "Invalid Email Or Password"
  end

  erb :index
end


get '/logout' do

  extension = "/users/sign_out"

  output = HTTParty.delete(address + extension,
      :query => {  api_token: session[:token],
                   user_id: session[:user_id]  })

  clear_token

  redirect '/'
end