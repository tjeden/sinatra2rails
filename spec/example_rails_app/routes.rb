Sinatra::Application.routes.draw do |map|
  match "/" => "sinatra#"
  match "/dupa" => "sinatra#dupa"
end
