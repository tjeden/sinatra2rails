require 'sinatra2rails'

s2r = Sinatra2Rails.new('pong.rb')
s2r.migrate_controllers

