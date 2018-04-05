require './lib/response'
class Controller
  attr_reader :server,
              :response

  def initialize(server)
    @server = server
    @response = Response.new(server)
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
      response.root_response(parse_headers)
    elsif path == "/hello"
      print "hello"
      response.hello_response +
      response.root_response(parse_headers)
    elsif path == "/datetime"
      response.datetime_response +
      response.root_response(parse_headers)
    elsif path == "/shutdown"
      response.shutdown_response +
      response.root_response(parse_headers)
    elsif path == "/word_search"
      parsed_params = parse_params(params)
      response.word_search_response(parsed_params['word']) +
      response.root_response(parse_headers)
    end
  end
end
