get '/' do
  @type = 'homepage'
  @results = Post.all
  erb :index
end

get '/search' do
  @type = params[:type]
  @term = params[:term]
  @results = []
  if @type == "tag"
    tag = Tag.find_by_name(@term)
    @results = tag.posts if tag
  elsif @type == "email"
    user = User.find_by_email(@term)
    @results = user.posts if user
  end
  erb :index
end
