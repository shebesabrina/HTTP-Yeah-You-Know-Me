require 'minitest/autorun'
require 'minitest/pride'
require './lib/parse_server'
require 'faraday'
require 'pry'

class ParseServerTest < Minitest::Test
  def setup
  @server = ParseServer.new
  @conn = Faraday.new(:url => 'localhost:9292')
  @server.run_server
  end
  # def test_it_exists
  #   assert_instance_of ParseServer, server
  # end
  #
  # def test_it_starts_wirth_empty_request_lines
  #   server = ParseServer.new
  #   assert_equal [], server.request_lines
  # end

  def test_hello_request
    result = "<h1>Hello, World! (1)</h1>"
    assert_equal @conn.get('/hello'), result
    @server.shutdown
  end
  #
  # def test_root_request
  #
  # end
  #
  # def test_datetime_request
  #
  # end
  #
  # def test_shutdown_request
  #
  # end

  # def test_can_set_request_lines
  #   server = ParseServer.new #this should be a mock test
  #   expected = "GET /shutdown HTTP/1.1"
  #
  #   assert_equal expected, server.set_request_lines.first
  # end
end
