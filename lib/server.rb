require 'socket'

class ParseServer

  # def root_response
  #   verb = request[0].split[0]
  #   path =  request[0].split[1]
  #   protocol = request[0].split[2]
  #   host = request[1].split[0]
  #   port = request[1].split(":")[2]
  #   accept
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

  count = 0
  tcp_server = TCPServer.new(9292)
  loop do
  connection = tcp_server.accept


  puts "ready for a request"
  request_lines = []

  while (line = connection.gets) && !line.chomp.empty?
    request_lines << line.chomp
  end

  puts "Got a request:"
  # puts request_lines.inspect

  verb = request_lines[0].split[0]
  path =  request_lines[0].split[1]
  protocol = request_lines[0].split[2]
  host = request_lines[1].split[0]
  port = request_lines[1].split(":")[2]
  accept = request_line[-4].split(":")[1]

  "<pre>
  Verb: #{verb}
  Path: #{path}
  Protocol: #{protocol}
  Host: #{host}
  Port: #{port}
  Origin: #{host}
  Accept: #{accept}
  </pre>"

  puts "Sending response."
  response = "<pre>" + request_lines.join("\n") + "</pre>"

  # response = "<h1>Hello, World! #{count += 1}</h1>"

  output = "<html><head></head><body>#{response}</body></html>"
  headers = ["http/1.1 200 ok",
            "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
            "server: ruby",
            "content-type: text/html; charset=iso-8859-1",
            "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  connection.puts headers
  connection.puts output

  puts ["wrote this response: ", headers, output].join("\n")
  connection.close

  puts "\nResponse sent, now exiting"
  end
end
