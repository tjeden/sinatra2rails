#simple sinatra app

require 'rubygems'
require 'sinatra'
require 'haml'
require "digest/sha1"


get '/' do
  haml :index
  123.to_s
  puts "haha"
end

get '/dupa' do
  haml :dupa
  puts 12**2
end

post '/create' do
  "123".to_i
end
