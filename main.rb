require 'sinatra/base'
require 'YAML'
require './classes/users'

class ConfigServer < Sinatra::Base
  use_auth = false
  config = YAML::load_file(File.join(Dir.pwd, 'config', 'config.yml'))
  users = YAML::load_file(File.join(Dir.pwd, 'config', 'users.yml'))
  configure :production, :development do
    enable :logging
  end

  config[:settings].each do |settings, value|
    use_auth = value["use_auth"]
  end

  usersbase = Users.new
  users[:users].each do |user, details|
    usersbase.add_user(User.new(user, details[:token], details[:applications]))
    #Это для заполнения приложений и итерирования
    # p.ids.push("55")
    #
    # #iterate
    # p.ids.each do |i|
    #   puts i
    # end
  end

  get '/' do
    # Сделать проверку наличия у пользователя прав на приложение настройки которого он запрашивает
    req_token = request.env["HTTP_APIKEY"]
    user = usersbase.find_by_token(req_token)
    if use_auth
      halt 400, 'Missing api token!' unless !req_token.nil?
      halt 401, 'No user with this token!' unless user.instance_of? User
      'Hello from MyApp!'
    else
      'Hello from MyApp! no auth'
    end
  end
  run!
end
