get '/posts' do
  # get page displaying all posts
  # save until end
  redirect '/'
end

get '/posts/new' do
  if logged_in?
    erb :post_new
  else
    redirect '/'
  end
end

post '/posts' do
  post = Post.create(params[:post])
  if post.valid?
    user = current_user
    user.posts << post
    post.update_tags(params[:tags])
    redirect "/posts/#{post.id}"
  else
    p post.errors.full_messages
    redirect "/posts/new"
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  @tags = Tag.stringify(@post.tags)
  erb :post_page
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  @tags = Tag.stringify(@post.tags)
  if logged_in? && current_user == @post.user
    erb :post_edit
  else
    p 'access denied'
    redirect "/posts/#{@post.id}"
  end
end

post '/posts/:id/edit' do
  post = Post.find(params[:id])
  if post.update_attributes(params[:post])
    post.save
    post.update_tags(params[:tags])
    redirect "/posts/#{post.id}"
  else
    p 'fields cannot be blank'
    redirect "/posts/#{post.id}/edit"
  end
end

get '/posts/:id/delete' do
  post = Post.find(params[:id])
  user = post.user
  if logged_in? && current_user == user
    post.destroy
    redirect "/users/#{user.id}"
  else
    p 'access denied'
    redirect "/posts/#{post.id}"
  end
end
