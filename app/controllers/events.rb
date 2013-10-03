#======== GET ==========================

get "/event/view/:event" do
  @event = Event.find(params[:event])
  if @event.creator == current_user
    erb :view_event
  else
    erb :view_event
  end
end


#======== POST ===========================
post '/event/create' do
  p params
  event = Event.new(params[:event])
  event.creator = current_user
  event.save
  @error = event.errors.full_messages

  if @error.any?
    @error = @error.join(", ")
    erb :index
  else
    redirect to "/user/home"
  end
end

post "/event/destroy" do 
  event = Event.find(params[:event])
  if event.creator == current_user
    name = event.name
    event.destroy
    redirect to '/user/home?del=true'
  else
    redirect to '/user/home?fail=true'
  end
end
