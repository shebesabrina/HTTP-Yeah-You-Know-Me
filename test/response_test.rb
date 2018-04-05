require 'minitest/autorun'
require 'minitest/pride'
require './lib/response'
require 'pry'
class ResponseTest < Minitest::Test
  def test_it_exists
    response = Response.new("localhost:9292")
    assert_instance_of Response, response
  end
end
