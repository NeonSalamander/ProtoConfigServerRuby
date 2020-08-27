require 'minitest/autorun'
require '../lib/users'

class TestUsers < Minitest::Unit::TestCase
  def setup

    @object = Users.new

  end
end
