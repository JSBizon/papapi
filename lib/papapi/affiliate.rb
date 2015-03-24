module Papapi
  require_relative 'grid_request'
  require_relative 'multi_request'
  class Affiliate

    def initialize(session)
      @session = session
      raise "Affiliate session is required" if !@session.is_affiliate?
      @response = nil
    end

    def load
      data = Papapi::FormRequest.new('Pap_Affiliates_Profile_PersonalDetailsForm', 'load', affiliate_session)
      @response = request.send
      self
    end

    def id
      @response ? @response[:userid] : nil
    end

    def [] (key)
      fields[key.to_sym]
    end

  end
end
