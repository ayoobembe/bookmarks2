require 'sinatra/base'
require 'data_mapper'
require 'sinatra'
require 'rack-flash'
require './lib/data_mapper_setup'
# class Bookmarks2 < Sinatra::Base

set :views, Proc.new{File.join(root,'..', 'views')}
use Rack::Flash
use Rack::MethodOverride

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
	@user = User.new
	erb :"users/new"
end

post '/users' do 
	@user = User.new(:email => params[:email],
							:password => params[:password],
							:password_confirmation => params[:password_confirmation])
	if @user.save
		session[:user_id] = @user.id 
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end

end

get '/sessions/new' do 
	erb :"sessions/new"
end

post '/sessions' do 
	email, password = params[:email], params[:password]
	user = User.authenticate(email,password)
	# p user
	if user 
		session[:user_id] = user.id 
		redirect to('/')
	else
		flash[:errors]=["The email or password is incorrect"]
		erb :"sessions/new"
	end
end

delete '/sessions' do 
	session.delete(:user_id)
	erb :"sessions/new"
end


# helpers do 
# 	def current_user
# 		@current_user ||= User.get(session[:user_id]) if session[:user_id]
# 	end
# end








#   run! if app_file == $0
# end
