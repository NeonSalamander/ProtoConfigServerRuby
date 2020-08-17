require 'sinatra/base'
require 'YAML'
require './classes/users'

class ConfigServer < Sinatra::Base
  use_auth = false
  port = 3000 # default
  config = YAML::load_file(File.join(Dir.pwd, 'config', 'config.yml'))
  users = YAML::load_file(File.join(Dir.pwd, 'config', 'users.yml'))
  configure :production, :development do
    enable :logging
  end
  config[:settings].each do |settings, value|
    use_auth = value['use_auth']
    port = value['port']
  end

  set :port, port

  usersbase = Users.new
  users[:users].each do |user, details|
    usersbase.add_user(User.new(user, details[:token], details[:applications]))
  end

  get '/:application' do
    req_token = request.env['HTTP_APIKEY']
    user = usersbase.find_by_token(req_token)
    if use_auth
      halt 400, 'Missing api token!' unless !req_token.nil?
      halt 401, 'No user with this token!' unless user.instance_of? User
      halt 403, 'No access to application settings' unless user.canViewConfiApplication(params['application'])
      'Hello from MyApp!'
    else
      'Hello from MyApp! no auth'
    end
  end
  run!
end
