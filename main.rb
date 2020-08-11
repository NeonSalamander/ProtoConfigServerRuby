require 'sinatra/base'
require 'YAML'
require './classes/users'

users = Users.new
users.add_user(222)
users.add_user(555)
users.add_user(777)
users.add_user(333)

users.iterator.each do |item|
  puts item
end


# class ConfigServer < Sinatra::Base
#   config = YAML::load_file(File.join(Dir.pwd, 'config', 'config.yml'))
#   users = YAML::load_file(File.join(Dir.pwd, 'users', 'users.yml'))
#   configure :production, :development do
#     enable :logging
#   end
#
#   get '/' do
#     request.env.each do |key, value|
#       puts key
#
#     end
#     if request.env["HTTP_APIKEY"] != "d4c74594d841139328695756648b6bd6"
#       halt 500
#     end
#     "Hello from MyApp!"
#   end
#   run!
# end
#
