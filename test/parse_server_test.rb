require 'minitest/autorun'
require 'minitest/pride'
require './lib/parse_server'
require 'faraday'
require 'pry'

class ParseServerTest < Minitest::Test
  def test_it_exists
    server = ParseServer.new
    assert_instance_of ParseServer, server
  end

  def test_it_starts_wirth_empty_request_lines
    server = ParseServer.new
    assert_equal [], server.request_lines
  end

  def test_can_set_request_lines
    server = ParseServer.new #this should be a mock test
    expected = "GET /shutdown HTTP/1.1"

    assert_equal expected, server.set_request_lines.first
  end
end
