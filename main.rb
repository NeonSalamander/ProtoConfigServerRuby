require 'sinatra/base'
require 'YAML'
require './classes/users'

# users = YAML::load_file(File.join(Dir.pwd, 'config', 'users.yml'))
#
# usersbase = Users.new
# users[:users].each do |user, details|
#   usersbase.add_user(User.new(user, details[:token]))
# end
#
#
# usersbase.iterator.each do |item|
#   puts item.token
# end
# findby = usersbase.find_by_token('7777777')
# puts findby


class ConfigServer < Sinatra::Base
  config = YAML::load_file(File.join(Dir.pwd, 'config', 'config.yml'))
  users = YAML::load_file(File.join(Dir.pwd, 'config', 'users.yml'))

  usersbase = Users.new
  users[:users].each do |user, details|
    usersbase.add_user(User.new(user, details[:token]))
  end

  configure :production, :development do
    enable :logging
  end

  get '/' do
    req_token = request.env["HTTP_APIKEY"]
    user = usersbase.find_by_token(req_token)
    puts user

    if user.instance_of? User
      "Hello from MyApp!"
    else
      halt 500
    end
  end
  run!
end

