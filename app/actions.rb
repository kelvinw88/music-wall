# Homepage (Root path)
helpers do

  def login?
    if session[:name].nil?
      return false
    else
      return true
    end
  end

  def username
    return session[:name]
  end

  def get_user_name(id)
    user = User.find_by(id: id)
    user.name if user
  end


end

get '/' do
  erb :index
end

get '/songs' do
  @vote_history = VoteHistory.all
  @songs = Song.all.sort_by{|song| song.vote_histories.count}.reverse
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(
  song_title: params[:song_title],
  author: params[:author],
  url: params[:url],
  )
  if @song.save
    @song.user_id = session[:id]
    @song.save

    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/songs/:id/upvote' do
  @song = Song.find params[:id]
  unless VoteHistory.find_by(user_id: session[:id],song_id: @song.id)
    @vote_history = VoteHistory.new(user_id: session[:id] ,song_id: @song.id)
    @vote_history.save
  end
  redirect '/songs'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(
  name: params[:name],
  email: params[:email],
  password: params[:password],
  )
  if @user.save
    redirect "/songs"
  else
    erb :'users/new'
  end
end

get '/login' do
  erb :'login'
end

post '/login_check' do
  email = params[:email]
  password = params[:password]
  user = User.where(email: email).where(password: password)[0]
    if user
      session[:name] = user.name
      session[:id] = user.id

      redirect '/songs'
    else
      erb :'login'
    end
end

get '/logout' do
  session[:name] = nil
  erb :index
end
