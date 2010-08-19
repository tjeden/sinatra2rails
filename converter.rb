require 'sinatra2rails'

s2r = Sinatra2Rails.new('test_sinatra_app/pong.rb')
s2r.migrate_controllers
s2r.migrate_routes

