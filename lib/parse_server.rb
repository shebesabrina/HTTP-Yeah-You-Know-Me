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

  def parse_headers(request_lines)
    request_lines[0].split(" ") +
    request_lines[1].split(" ")[1].split(":") +
    [ request_lines[6].split(" ")[1] ]
  end

  def generate_root_response(parsed_headers)
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

  def set_request_lines(connection)
    puts "ready for a request"

    while (line = connection.gets) and !line.chomp.empty?
      @request_lines << line.chomp
    end
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
        @shutdown = true
      end
    end
  end

  def hello_response
    "<h1>Hello, World! #{@count += 1}</h1>"
  end

  def datetime_response
    Time.now.strftime('%I:%M on %A, %B %d, %Y')
  end

  def shutdown
    @shutdown = true

  end

  def response_path(parse_headers)
    verb, path, protocol, host, port, accept = parse_headers
    if path == "/"
      self.generate_root_response(parse_headers)
    elsif path == "/hello"
      print "hello"
      self.hello_response
    elsif path == "/datetime"
      self.datetime_response
    elsif path == "/shutdown"
       "Total Requests: #{@count}"
    end
  end

end

server = ParseServer.new
server.run_server
