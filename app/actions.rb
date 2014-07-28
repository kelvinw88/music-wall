# Homepage (Root path)
get '/' do
  @songs = Song.all
  erb :index
end

get '/songs' do
  @songs = Song.all
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
    redirect '/songs'
  else
    erb :'songs/new'
  end
end
