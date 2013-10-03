#======== GET ==========================
get '/user/home' do

  if current_user
    @message = "You can't destroy that event." if params[:fail]
    @message = "Your event was deleted." if params[:del]
    erb :user_home
  else
    redirect to "/"
  end
end
