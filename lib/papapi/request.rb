module Papapi
  class Request

    SERVER_CLASS_NAME = 'Gpf_Rpc_Server'
    RUN_METHOD = 'run'
    BODY_DATA_NAME = 'D'

    attr_accessor :class_name,
                  :method_name,
                  :session

    attr_reader :requests

    def initialize (class_name, method_name, session)
      @class_name = class_name
      @method_name = method_name
      @session = session
      @params = {}
      @requests = []
    end

    def set_param(name, value)
      @params[name] = value
    end

    def set_params(p)
      @params = @params.merge(p)
    end

    def add_request(request)
      @requests << request
    end

    def to_data
      {
        "C" => @class_name,
        "M" => @method_name,
      }.merge(@params)
    end

    def send
      vars = {
          "C" => SERVER_CLASS_NAME,
          "M" => RUN_METHOD,
          "isFromApi" => "Y",
          "requests" => ([self] + @requests).map { |r| r.to_data }
      }
      vars['S'] = @session.id if @session && @session.id

      request_body = {BODY_DATA_NAME => vars.to_json }

      p "REQUEST# #{vars}" if @session.debug
      http_response = send_now(@session.url, request_body)
      p "RESPONE# #{http_response.body}" if session.debug
      response(http_response)
    end

    def response(http_response)
      Response.new(http_response, self)
    end

    def send_now(url, request_body)
      Net::HTTP.post_form(URI.parse(url), request_body)
    end

  end
end