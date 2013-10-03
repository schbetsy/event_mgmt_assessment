#======== GET ==========================

get "/event/view/:event" do
  @event = Event.find_by_id(params[:event])
  if @event == nil
    erb :DNE
  else
    if @event.creator == current_user
      erb :edit_event
    else
      erb :view_event
    end
  end
end


#======== POST ===========================
post '/event/create' do
  p params
  event = Event.new(params[:event])
  event.creator = current_user
  event.save
  @error = event.errors.full_messages

  if request.xhr?
    "success"
  else
    if @error.any?
      @error = @error.join(", ")
      erb :index
    else
      redirect to "/user/home"
    end
  end
end

post "/event/destroy" do 
  event = Event.find(params[:event])
  if event.creator == current_user
    event.destroy
    redirect to '/user/home?del=true'
  else
    redirect to '/user/home?fail=true'
  end
end

post "/event/update" do
  @event = Event.find(params[:id])
  if @event.creator == current_user
    @event.update_attributes(params[:event])
    @error = @event.errors.full_messages
    if @error.any?
      @error = @error.join(", ")
      erb :edit_event
    else
      redirect to "/event/view/#{@event.id}"
    end
  else
    # Error message: "you can't update that record"
  end
end
