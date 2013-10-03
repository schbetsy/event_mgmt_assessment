#======== GET ==========================
get '/' do
  @error_login = "username or password incorrect" if params[:error_login]
  @error_signup = "something went wrong" if params[:error_signup]
  erb :index
end

get '/log_out' do
  session.clear
  redirect to '/'
end

#======== POST ===========================

post '/sign_in' do 
  user = User.authenticate(params[:user])
  if user
    session[:user_id] = user.id
    redirect to "/user/home"
  else
    redirect to '/?error_login=true' 
  end

end

post '/sign_up' do 
  user = User.create(params[:user])
  @error_signup = user.errors.full_messages
  if @error_signup.any?
    @error_signup = @error_signup.join(", ")
    erb :index
  else
    redirect to "/user/home"
  end
end
