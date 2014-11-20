require 'sinatra/base'

class Bookmarks2 < Sinatra::Base
  get '/' do
    'Hello Bookmarks2!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
