require 'socket'

tcp_server = TCPServer.new(9292)

connection = tcp_server.accept

puts "ready for a request"
request_lines = []

while (line = connection.gets) && !line.chomp.empty?
  request_lines << line.chomp
end

puts "Got a request:"
puts request_lines.inspect

puts "Sending response."
response = "<pre>" + request_lines.join("\n") + "</pre>"
# response = "<h1>SABRINA IS SO AWESOME!!</h1>"
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