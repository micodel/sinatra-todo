
helpers do

	def give_token
		session[:token] = @api_response["api_token"]
    session[:user_id] = @api_response["id"]
	end

  def clear_token
    session[:token] = nil
    session[:user_id] = nil
  end

  def validate_session
    if session[:token] == nil
      redirect '/'
    end
  end

end