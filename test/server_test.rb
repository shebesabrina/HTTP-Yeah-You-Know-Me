<pre>
Verb: POST
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
</pre>

[4] pry(main)> verb = request[0].split[0]
=> "GET"
[7] pry(main)> path = request[0].split[1]
=> "/favicon.ico"
[8] pry(main)> path = request[0].split[2]
=> "HTTP/1.1"
[9] pry(main)> request[1]
=> "Host: localhost:9292"
[13] pry(main)> request[1].split(":")[2]
=> "9292"
