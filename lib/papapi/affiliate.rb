module Papapi
  require_relative 'grid_request'
  require_relative 'multi_request'
  class Affiliate

    def initialize(session, response = nil)
      @session = session
      if @session.is_affiliate?
        @class = 'Pap_Affiliates_Profile_PersonalDetailsForm'
      else
        @class = 'Pap_Signup_AffiliateForm'
      end
      @response = response
      @user_id = nil
    end

    def load
      request = Papapi::FormRequest.new(@class, 'load', @session)

      unless @user_id.nil?
        request.set_field("Id", @user_id)
        request.set_field("userid", @user_id)
      end

      @response = request.send
      self
    end

    def id
      @response ? @response[:userid] : @user_id
    end

    def id=(user_id)
      @user_id = user_id
    end

    def [] (key)
      @response ? @response[key.to_sym] : nil
    end

  end
end
