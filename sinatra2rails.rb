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
  attr_accessor :file_name, :ruby2ruby, :parse_tree, :sexp_array, :finder
  
  def initialize( file_name)
    @file_name = file_name
    @parse_tree = ParseTree.new
    @ruby2ruby = Ruby2Ruby.new
    @sexp_array = @parse_tree.process(File.open(@file_name).read)
    @finder = EntityFinder.new
  end

  def migrate_controllers
    finder.find_entities(@sexp_array, :iter).each do |elem|
      puts "---"
      puts ruby2ruby.process(elem[3])
    end
  end

  def migrate_models
  end

  def migrate_views
  end
end
