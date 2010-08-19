# having fun with ruby2ruby and parsetree

require 'rubygems'
require 'ruby2ruby'
require 'parse_tree'
require 'pp'

ruby      = "def a\n  puts 'A'\nend\n\ndef b\n  a\nend"
parser    = ParseTree.new
ruby2ruby = Ruby2Ruby.new
sexp      = parser.process(ruby)

pp sexp

puts ruby2ruby.process(sexp)

