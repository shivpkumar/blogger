get '/users' do
  # get page displaying all users
  # save until end
  redirect '/'
end

post '/users' do
  user = User.create(params[:user])
  if user.valid?
    create_session(user)
    redirect "/users/#{user.id}"
  else
    p user.errors.full_messages
    redirect "/"
  end
end

get '/users/:id' do
  @user = User.find(params[:id])
  erb :user_page
end
