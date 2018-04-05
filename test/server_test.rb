require 'minitest/autorun'
require 'minitest/pride'
require './lib/response'
require 'faraday'
require 'pry'

class ServerTest < Minitest::Test

  def test_it_exists

  connection = Faraday.new(:url => 'localhost:9292')

  assert Faraday, connection
  end

  def test_faraday_communicating_with_localhost_9292

    connection = Faraday.new(:url => 'localhost:9292')
    response = connection.inspect

    assert response.include?("9292")
  end

  def test_hello_request
    skip
    connection = Faraday.get(:url => "localhost:9292")
    result =
    "<html>
    <head></head>
    <body>
        <h1>Hello, World! 1</h1>
        <pre>
    Verb: GET
    Path: /hello
    Protocol:
    Host: HTTP/1.1
    Port: localhost
    Origin: HTTP/1.1
    Accept: 9292
    </pre>
    </body>
    </html>"
    assert connection.get('/hello'), result
  end

  def test_response_includes_GET
    skip
    connection = Faraday.new(:url => "localhost:9292")
    result =
    "<html>
    <head></head>
    <body>
        <pre>
    Verb: GET
    Path: /
    Protocol:
    Host: HTTP/1.1
    Port: localhost
    Origin: HTTP/1.1
    Accept: 9292
    </pre>
    </body>
    </html>"
    assert connection.get('/'), result
  end

  def test_root_request
    skip
    connection = Faraday.new(:url => "localhost:9292")
    result =
    "<html>
    <head></head>
    <body>
        <pre>
    Verb: GET
    Path: /
    Protocol:
    Host: HTTP/1.1
    Port: localhost
    Origin: HTTP/1.1
    Accept: 9292
    </pre>
    </body>
    </html>"
    assert connection.get('/'), result
  end

  def test_datetime_request
    skip
    connection = Faraday.new(:url => "localhost:9292")
    result =
    "<html>
    <head></head>
    <body>07:45 on Thursday, April 05, 2018
        <pre>
    Verb: GET
    Path: /datetime
    Protocol:
    Host: HTTP/1.1
    Port: localhost
    Origin: HTTP/1.1
    Accept: 9292
    </pre>
    </body>
    </html>"
    assert connection.get('/datetime'), result
  end

  def test_shutdown_request
    skip
    connection = Faraday.new(:url => "localhost:9292")
    result =
    "<html>
    <head></head>
    <body>Total Requests: 1
        <pre>
    Verb: GET
    Path: /shutdown
    Protocol:
    Host: HTTP/1.1
    Port: localhost
    Origin: HTTP/1.1
    Accept: 9292
    </pre>
    </body>
    </html>"
    assert connection.get('/shutdown'), result
  end
end
