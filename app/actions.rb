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

end

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
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
    binding.pry
    redirect '/songs'
  else
    erb :'songs/new'
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
      binding.pry
      redirect '/songs'
    else
      erb :'login'
    end
end

get '/logout' do
  session[:name] = nil
  erb :index

end
