require 'sinatra'
require 'sqlite3'
require 'json'
require 'pry'
require './db/song'
require './db/connection'
require 'active_record'
require 'bcrypt'
include FileUtils::Verbose

use Rack::MethodOverride
set :method_override, true
set :public_folder, '../public'

get '/' do
	puts '/'
	send_file File.join(settings.public_folder, 'index.html')
end
get '/public/bundle.js' do
	puts 'public'
	send_file File.join(settings.public_folder, 'bundle.js')
end
get '/songs' do
	headers 'Access-Control-Allow-Origin' => '*'
	headers 'Access-Control-Allow-Methods' => 'GET'
	content_type :json
	songs = Song.all()
	songs.to_json
end

get '/song/:id' do 
	headers 'Access-Control-Allow-Origin' => '*'
	headers 'Access-Control-Allow-Methods' => 'GET'
	content_type :json
	song = Song.find_by(id: params[:id])
	song.to_json
end

post '/song' do
	headers 'Access-Control-Allow-Origin' => '*'
	headers 'Access-Control-Allow-Methods' => 'POST'
	content_type :json
	Song.create(title: params[:title], artist: params[:artist], album: params[:album], track: params[:track], tag: params[:tag], score: params[:score])
	song = Song.order(:id).last
	song.to_json
end


put '/song/:id' do
	headers 'Access-Control-Allow-Origin' => '*'
	headers 'Access-Control-Allow-Methods' => 'PUT'
	content_type :json
	song = Song.find_by(id: params[:id].to_i)
	song.update(title: params[:title], artist: params[:artist], album: params[:album], track: params[:track], tag: params[:tag], score: params[:score])
	returnsong = Song.find_by(id: params[:id].to_i)
	returnsong.to_json
	# redirect('/')
end





