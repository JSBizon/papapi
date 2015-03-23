module Papapi
  class MultiRequest

    def initialize(requests = nil)
      @request = nil
      if requests && requests.length > 0
        @request = requests[0]
        requests.slice(1, requests.count-1).each do |r|
          @request.add_request(r)
        end
      end
    end

    def add_request(request)
      if ! @request
        @request = request
      else
        @request.add_request(request)
      end
    end

    def send
      resp = @request.send
      [resp] + resp.responses
    end
  end
end
