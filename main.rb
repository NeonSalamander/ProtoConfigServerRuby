require 'sinatra/base'
require 'YAML'
require 'logger'
require 'rufus/scheduler'
require './lib/users'
require './lib/git_manager'

class ConfigServer < Sinatra::Base

  settings_server = {}
  config = YAML::load_file(File.join(Dir.pwd, 'config', 'config.yml'))
  users = YAML::load_file(File.join(Dir.pwd, 'config', 'users.yml'))

  configure :production, :development do
    enable :logging
    # Это для продакшона ага, почитай как env разделять
    # Dir.mkdir('logs') unless File.exist?('logs')
    # $logger = Logger.new('logs/common.log','weekly')
    # $logger.level = Logger::WARN
    # $stdout.reopen("logs/output.log", "w")
    # $stdout.sync = true
    # $stderr.reopen($stdout)
     $logger = Logger.new(STDOUT)
  end
  config[:settings].each do |settings, value|
    settings_server[settings] = value
  end

  ENV['TZ'] = settings_server['timezone']
  scheduler = Rufus::Scheduler.new

  check_repo = GitRepository.new(settings_server['repository_url'])
  scheduler.every "#{settings_server['cron_duration']}", check_repo

  set :port, settings_server['port']

  usersbase = Users.new
  users[:users].each do |user, details|
    usersbase.add_user(User.new(user, details[:token], details[:applications]))
  end

  get '/:application' do
    req_token = request.env['HTTP_APIKEY']
    user = usersbase.find_by_token(req_token)
    if settings_server['use_auth']
      logger.info('логировать все запросы конфигураций приложения')
      halt 400, 'Missing api token!' unless !req_token.nil?
      halt 401, 'No user with this token!' unless user.instance_of? User
      halt 403, 'No access to application settings' unless user.canViewConfiApplication(params['application'])
      res = check_repo.get_config(params['application'])
      res
    else
      res = check_repo.get_config(params['application'])
      res
    end
  end
  run!
end
