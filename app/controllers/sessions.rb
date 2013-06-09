post '/sessions' do
  user = User.authenticate(params[:user])
  if user
    create_session(user)
    redirect "/users/#{user.id}"
  else
    p 'invalid email or password'
    redirect '/'
  end
end

get '/sessions/:id/delete' do
  session.clear
  redirect '/'
end
