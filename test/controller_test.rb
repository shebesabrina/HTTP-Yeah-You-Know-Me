require 'minitest/autorun'
require 'minitest/pride'
require './lib/controller'
require './lib/response'
require 'pry'
class ControllerTest < Minitest::Test
  def test_it_exists
    controller = Controller.new("localhost:9292")
    assert_instance_of Controller, controller
  end
end
