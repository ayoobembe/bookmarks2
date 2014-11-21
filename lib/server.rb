require 'sinatra/base'
require 'data_mapper'
require 'sinatra'

# class Bookmarks2 < Sinatra::Base

set :views, Proc.new{File.join(root,'..', 'views')}

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/bookmarks2_#{env}")
require './lib/link'
require './lib/tag'
require './lib/user'
DataMapper.finalize
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, 'super secret'

helpers do 
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end

 
get '/' do 
	@links = Link.all 
	erb :index
end

post '/links' do 
	url = params["url"]
	title = params["title"]
	tags = params["tags"].split(" ").map do |tag|
		Tag.first_or_create(:text => tag) #why don't we have to also assign :link?
	end
	Link.create(:url => url, :title =>title, :tags => tags)
	redirect to('/')
end

get '/tags/:text' do 
	tag = Tag.first(:text => params[:text])
	@links = tag ? tag.link : [] #if tag exists @links = tag.link, else @links = empty array
	erb :index
end

get '/users/new' do 
	erb :"users/new"
end

post '/users' do 
	user = User.create(:email => params[:email],
							:password => params[:password])
	session[:user_id] = user.id 
	redirect to('/')
end









#   run! if app_file == $0
# end
