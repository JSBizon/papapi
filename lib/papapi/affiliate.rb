module Papapi
  require_relative 'grid_request'
  require_relative 'multi_request'
  class Affiliate

    def initialize(session, response = nil)
      @session = session
      raise "Affiliate session is required" if !@session.is_affiliate?
      @response = response
    end

    def load
      request = Papapi::FormRequest.new('Pap_Affiliates_Profile_PersonalDetailsForm', 'load', @session)
      @response = request.send
      self
    end

    def id
      @response ? @response[:userid] : nil
    end

    def [] (key)
      @response ? @response[key.to_sym] : nil
    end

  end
end
