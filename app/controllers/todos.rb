
require 'httparty'
require 'json'


address = "http://recruiting-api.nextcapital.com/users"

# All List Items
get '/list' do
  validate_session

  extension = "/#{session[:user_id]}/todos.json?api_token=#{session[:token]}"

  output = HTTParty.get(address + extension)

  @list = JSON.parse(output.body)

  erb :"todos/index"
end


# Add A List Item
get '/list/new' do
  validate_session
  erb :"todos/new"
end



post '/list/new' do
  validate_session

  extension = "/#{session[:user_id]}/todos"

  HTTParty.post(address + extension,
      :query => {  api_token: session[:token],
                   :todo => {description: params[:description]}  })

  redirect "/list"
end


get '/list/:item_id/edit' do
  validate_session

  extension = "/#{session[:user_id]}/todos/#{params[:item_id]}.json?api_token=#{session[:token]}"

  output = output = HTTParty.get(address + extension)

  @item = JSON.parse(output.body)

  erb :"todos/edit"

end


# update description
post '/list/:item_id/edit' do
  validate_session

  extension = "/#{session[:user_id]}/todos/#{params[:item_id]}"

  output = HTTParty.put(address + extension,
      :query => {  api_token: session[:token],
                   :todo => {description: params[:description]}  })

  redirect "/list"
end


# Mark as complete
post '/list/:item_id/complete' do
  validate_session

  target_task_extension = "/#{session[:user_id]}/todos/#{params[:item_id]}.json?api_token=#{session[:token]}"

  target_task = HTTParty.get(address + target_task_extension)

  extension = "/#{session[:user_id]}/todos/#{params[:item_id]}"

  output = HTTParty.put(address + extension,
    :query => {  api_token: session[:token],
                 :todo => {is_complete: toggle_complete(target_task)}  })

  redirect "/list"
end
