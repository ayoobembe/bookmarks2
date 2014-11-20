require 'sinatra/base'
require 'data_mapper'
require 'sinatra'

# class Bookmarks2 < Sinatra::Base

set :views, Proc.new{File.join(root,'..', 'views')}

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/bookmarks2_#{env}")
require './lib/link'
DataMapper.finalize
DataMapper.auto_upgrade!

 
get '/' do 
	@links = Link.all 
	erb :index
end

post '/links' do 
	url = params["url"]
	title = params["title"]
	Link.create(:url => url, :title =>title)
	redirect to('/')
end







  # run! if app_file == $0
# end
