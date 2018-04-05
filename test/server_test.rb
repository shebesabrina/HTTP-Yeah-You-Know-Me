require 'minitest/autorun'
require 'minitest/pride'
require './lib/response'
require 'faraday'
require 'pry'

class ServerTest < Minitest::Test

  def test_it_exists
  skip
  connection = Faraday.new(:url => 'localhost:9292')

  assert_instance_of Faraday, connection
  end

  def test_verb_response

    connection = Faraday.new(:url => 'localhost:9292')
    response = connection.inspect

    assert response.include?("9292")
  end

  def test_hello_request
skip
    connection = Faraday.new(:url => "localhost:9292/hello")
    result = "<h1>Hello, World! (1)</h1>"
    assert connection.get('/hello'), result
  end

  def test_response_includes_GET
    skip
    connection = Faraday.new(:url => "localhost:9292/hello")
    result = "<h1>Hello, World! (1)</h1>"
    assert connection.get('/hello'), result
  end

  def test_root_request
    skip
    connection = Faraday.new(:url => "localhost:9292/hello")
    result = "<h1>Hello, World! (1)</h1>"
    assert connection.get('/hello'), result
  end

  def test_datetime_request
    skip
    connection = Faraday.new(:url => "localhost:9292/hello")
    result = "<h1>Hello, World! (1)</h1>"
    assert connection.get('/hello'), result
  end

  def test_shutdown_request
    skip
    connection = Faraday.new(:url => "localhost:9292/hello")
    result = "<h1>Hello, World! (1)</h1>"
    assert connection.get('/hello'), result
  end

end
