require 'socket'

class ParseServer
  attr_reader :tcp_server,
              :request_lines,
              :count

  def initialize(server = TCPServer.new(9292))
    @tcp_server = server
    @request_lines = []
    @count = 0
    @shutdown = false
  end

  def run_server
    until @shutdown
      connection = @tcp_server.accept

      self.set_request_lines(connection)

      puts "Got a request:"
      puts @request_lines.inspect

      headers = parse_headers(@request_lines)
      response = response_path(headers)

      self.send_response(response, connection)

      connection.close

      puts "\nResponse sent, now exiting"
      @request_lines = []
      if headers[1] == "/shutdown"
        shutdown
      end
    end
  end

  def parse_headers(request_lines)
    first_request_line = request_lines[0].split(' ')
    verb = first_request_line[0]
    path, params = first_request_line[1].split('?')
    protocol = first_request_line[2]

    [verb, path, params, protocol] +
    request_lines[1].split(" ")[1].split(":") +
    [ request_lines[6].split(" ")[1] ]
  end

  def parse_params(params)
    params_list = params.split("&")
    params_list.each_with_object({}) do |param_pair, memo|
      #memo is {}
      # an example of param_pair: 'word=elephant'
      #could use reduce but will need to explicitely return memo to build a hash instead of a string/
      key, value = param_pair.split('=')
      memo[key] = value
    end
  end

  def response_path(parse_headers)
    verb, path, params, protocol, host, port, accept = parse_headers
    if path == "/"
      self.root_response(parse_headers)
    elsif path == "/hello"
      print "hello"
      self.hello_response
    elsif path == "/datetime"
      self.datetime_response
    elsif path == "/shutdown"
      self.shutdown_response
    elsif path == "/word_search"
      parsed_params = parse_params(params)
      self.word_search_response(parsed_params['word'])
    end
  end

  def set_request_lines(connection)
    puts "ready for a request"

    while (line = connection.gets) and !line.chomp.empty?
      @request_lines << line.chomp
    end
  end

  def shutdown
    @shutdown = true
  end

  def set_output(response)
    "<html><head></head><body>#{response}</body></html>"
  end

  def set_headers(datetime_response, output)
    ["http/1.1 200 ok",
    "date: #{datetime_response}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def log(output, headers)
    ["wrote this response: ", headers, output].join("\n")
  end

  def send_response(response, connection)
    puts "Sending response."
    output = set_output(response)
    headers = set_headers(datetime_response, output)

    connection.puts headers
    connection.puts output
    puts log(output, headers)
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

  def hello_response
    "<h1>Hello, World! #{@count += 1}</h1>"
  end

  def datetime_response
    Time.now.strftime('%I:%M on %A, %B %d, %Y')
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
end

server = ParseServer.new
server.run_server
