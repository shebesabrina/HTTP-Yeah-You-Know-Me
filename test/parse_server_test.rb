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

    assert_equal expected, server.request_lines.first
  end

  def test_can_get_the_verb
skip
    server = ParseServer.new

    lines = "GETS SOMETHING SUPER COOL AND AWESOME AND STUFF"
    server.request_lines << lines

    expected = "GETS"
    assert_equal expected, server.verb
  end

  def test_can_get_the_path
skip
    server = ParseServer.new

    lines = "GETS SOMETHING SUPER COOL AND AWESOME AND STUFF"
    server.request_lines << lines

    expected = "SOMETHING"
    assert_equal expected, server.path
  end

  def test_can_get_the_protocol
skip
    server = ParseServer.new

    lines = "GETS SOMETHING SUPER COOL AND AWESOME AND STUFF"
    server.request_lines << lines

    expected = "SUPER"
    assert_equal expected, server.protocol
  end

  def test_can_get_the_host
skip
    server = ParseServer.new

    lines1 = "GETS SOMETHING SUPER COOL AND"
    lines2 =  "AWESOME AND STUFF"
    server.request_lines << lines1
    server.request_lines << lines2

    expected = "AWESOME"
    assert_equal expected, server.host
  end

  def test_can_get_the_port
skip
    server = ParseServer.new

    lines1 = "GETS SOMETHING SUPER COOL AND"
    lines2 =  "AWESOME: AND: STUFF:"
    server.request_lines << lines1
    server.request_lines << lines2

    expected = " STUFF"
    assert_equal expected, server.port
  end

  def test_can_get_the_accept
skip
    server = ParseServer.new

    lines = ["GET / HTTP/1.1", "Host: localhost:9292", "Connection: keep-alive", "Cache-Control: max-age=0", "Upgrade-Insecure-Requests: 1", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.162 Safari/537.36", "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8", "DNT: 1", "Accept-Encoding: gzip, deflate, br", "Accept-Language: en-US,en;q=0.9"]
    server.request_lines << lines

    expected = " STUFF"
    assert_equal expected, server.accept
  end


end















# <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>
#
# def root_response
#   verb = request[0].split[0]
#   path =  request[0].split[1]
#   protocol = request[0].split[2]
#   host = request[1].split[0]
#   port = request[1].split(":")[2]
#   accept = request_line[-4].split(":")[1]
#     "<pre>
#  Verb: #{verb}
#  Path: #{path}
#  Protocol: #{protocol}
#  Host: #{host}
#  Port: #{port}
#  Origin: #{host}
#  Accept: #{accept}
#  </pre>"
# end
