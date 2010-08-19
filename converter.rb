# quick and dirty proof-of-concept

require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'

require 'pp'

class EntityFinder
  attr_accessor :found
  
  def initialize
    @found = []
  end

  def find_entities(entity, detect=nil, detect2=nil)
    if(entity.is_a?(Array) && (entity[0] == detect) && (entity[2] == detect2))
      @found << entity
    elsif(entity.is_a?(Array))
      entity.each{|e| find_entities(e, detect, detect2)}
    end
    @found
  end
end

class Sinatra2Rails
  attr_accessor :file_name
  
  def initialize( file_name)
    @file_name = file_name
    pt = ParseTree.new
    ruby2ruby = Ruby2Ruby.new

    sexp_array = pt.process(File.open(@file_name).read)

    finder = EntityFinder.new
    finder.find_entities(sexp_array, :iter).each do |elem|
      puts "---"
      puts ruby2ruby.process(elem[3])
    end
  end
end

Sinatra2Rails.new('pong.rb')

