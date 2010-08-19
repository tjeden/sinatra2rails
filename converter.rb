# quick and dirty proof-of-concept

require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

require 'pp'

$found = []
def find_entities(entity, detect=nil, detect2=nil)
  ruby2ruby = Ruby2Ruby.new
  if(entity.is_a?(Array) && (entity[0] == detect) && (entity[2] == detect2))
    $found << entity
    puts "---"
    puts ruby2ruby.process(entity[3])
  elsif(entity.is_a?(Array))
    entity.each{|e| find_entities(e, detect, detect2)}
  else
    #fuck it
  end
end

pt = ParseTree.new
ruby2ruby = Ruby2Ruby.new

sexp_array = pt.process(File.open('pong.rb').read)

find_entities(sexp_array, :iter)

pp $found
