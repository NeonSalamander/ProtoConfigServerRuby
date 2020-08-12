require 'sinatra/base'
require 'YAML'
require './classes/users'

class ConfigServer < Sinatra::Base
  config = YAML::load_file(File.join(Dir.pwd, 'config', 'config.yml'))
  users = YAML::load_file(File.join(Dir.pwd, 'config', 'users.yml'))
  configure :production, :development do
    enable :logging
  end

  usersbase = Users.new
  users[:users].each do |user, details|
    usersbase.add_user(User.new(user, details[:token]))
  end


  get '/' do
    # Сделать проверку на сам факт использования аутентификации
    # Сделать проверку токена был ли он передан
    # Аутентификация уже есть
    # Сделать проверку наличия у пользователя прав на приложение настройки которого он запрашивает
    # Все это желательно через middleware
    req_token = request.env["HTTP_APIKEY"]
    user = usersbase.find_by_token(req_token)

    if user.instance_of? User
      "Hello from MyApp!"
    else
      halt 500
    end
  end
  run!
end

