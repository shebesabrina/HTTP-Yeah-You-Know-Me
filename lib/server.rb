require 'socket'
require './lib/response'
require './lib/controller'

class Server
  attr_reader :tcp_server,
              :request_lines,
              :shutdown,
              :controller,
              :response

  def initialize(server = TCPServer.new(9292))
    @tcp_server = server
    @request_lines = []
    @shutdown = false
    @controller = Controller.new(self)
    @response = Response.new(self)
  end

  def run_server
    until @shutdown
      connection = @tcp_server.accept
      self.set_request_lines(connection)
      puts "Got a request:"
      puts @request_lines.inspect
      headers = @controller.parse_headers(@request_lines)
      response = @controller.response_path(headers)
      self.send_response(response, connection)
      connection.close
      puts "\nResponse sent, now exiting"
      @request_lines = []
      if headers[1] == "/shutdown"
        @shutdown = true
      end
    end
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
    headers = set_headers(@response.datetime_response, output)

    connection.puts headers
    connection.puts output
    puts log(output, headers)
  end
end

server = Server.new
server.run_server
