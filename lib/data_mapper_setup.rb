
env = ENV['RACK_ENV'] || 'development'
DataMapper.setup(:default, "postgres://localhost/bookmarks2_#{env}")
require './lib/link'
require './lib/tag'
require './lib/user'
DataMapper.finalize
DataMapper.auto_upgrade!