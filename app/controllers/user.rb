get '/user/:id' do
  @user = User.find(params[:id])
  erb :profile
end

post '/user' do
  user = User.create(params[:user])
  create_session(user)
  redirect "/user/#{user.id}"
end

post '/session' do
  user = User.authenticate(params[:user])
  if user
    create_session(user)
  else
    p 'invalid email or password'
  end
  redirect "/user/#{user.id}"
end

get '/session/:id' do
  session.clear
  redirect '/'
end
