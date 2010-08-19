require 'rubygems'
require 'parse_tree'
require 'ruby2ruby'
require 'erb'

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
    @actions = []
    finder.find_entities(@sexp_array, :iter).each do |elem|
      action_name = elem[1][3][1][1].gsub(/\//,'')
      @actions << "\n  def #{action_name}\n"
      ruby2ruby.process(elem[3]).each_line { |line| @actions << "    #{line}" }
      @actions << "  end\n  "
    end
    rhtml = ERB.new(File.new("templates/sinatra_controller.erb").read)
    html_path = "test_rails_app/sinatra_controller.rb"
    html_file = File.new(html_path, "w")
    html_file.write(rhtml.result(binding))
    html_file.close
  end

  def migrate_routes
    @routes = []
    finder.find_entities(@sexp_array, :iter).each do |elem|
      action_name = elem[1][3][1][1]
      @routes << "  match \"#{action_name}\" => \"sinatra##{action_name.gsub(/\//,'')}\"\n"
    end
    rhtml = ERB.new(File.new("templates/routes.erb").read)
    html_path = "test_rails_app/routes.rb"
    html_file = File.new(html_path, "w")
    html_file.write(rhtml.result(binding))
    html_file.close
  end

  def migrate_models
  end

  def migrate_views
  end
end
