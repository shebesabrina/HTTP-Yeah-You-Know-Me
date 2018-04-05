require 'socket'
require 'pry'

class Response
  attr_reader :server

  def initialize(server)
    @server = server
    @count = 0
  end

  def datetime_response
    Time.now.strftime('%I:%M on %A, %B %d, %Y')
  end

  def hello_response
    "<h1>Hello, World! #{@count += 1}</h1>"
  end

  def shutdown_response
    "Total Requests: #{@count}"
  end

  def word_search_response(word)
    dictionary = File.read("/usr/share/dict/words")
    if dictionary.include?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

  def root_response(parsed_headers)
    verb, path, protocol, host, port, accept = parsed_headers
    "<pre>
    Verb: #{verb}
    Path: #{path}
    Protocol: #{protocol}
    Host: #{host}
    Port: #{port}
    Origin: #{host}
    Accept: #{accept}
    </pre>"
  end
end
