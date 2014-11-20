require 'sinatra/base'
require 'data_mapper'

# class Bookmarks2 < Sinatra::Base

env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/bookmarks2_#{env}")

require './lib/link'

DataMapper.finalize
DataMapper.auto_upgrade!

 
#   run! if app_file == $0
# end
