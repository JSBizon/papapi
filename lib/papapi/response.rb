module Papapi
  class Response

    REMOVE_VARS = ['name', 'correspondsApi', 'language']

    attr_reader :responses

    def initialize (http_response, request)
      @http_response = http_response
      @request = request
      @responses = []
      check_for_errors
    end

    def parsed
      return @parsed if @parsed
      if @http_response.is_a? Net::HTTPResponse
        parsed_response = JSON.parse(@http_response.body)
        @parsed = parsed_response.shift

        #handle multi responses
        @request.requests.each do |req|
          resp = parsed_response.shift
          @responses << req.response(resp) if resp
        end
      else
        @parsed = @http_response
      end
      @parsed
    end

    private

    def check_for_errors
      return if ! parsed.kind_of?(Hash)
      raise parsed['message'] if parsed['success'] != 'Y' && parsed['message']
      raise parsed['e']       if parsed['e']
    end

  end
end