require 'yaml'
require 'minitest/autorun'
require_relative '../lib/users'

class TestUsers < Minitest::Unit::TestCase
  def setup
    yaml_data = '---
:users:
  kandellak:
    :login: kandellak
    :password: passwordA
    :token: 5555555
    :applications:
      - test_app
      - cms
      - mail
      - microservices
      - libs
      - config_mail
  noirknight:
    :login: kandellaster
    :password: passwordB
    :token: 7777777
'
    users_hash = YAML.load(yaml_data)
    usersbase = Users.new
    users_hash[:users].each do |user, details|
      usersbase.add_user(User.new(user, details[:token], details[:applications]))
    end

    @object = usersbase

  end

  def test_users_count
    #assert_equal 2, @object.hash.size
  end

end
