module Papapi
  class Session

    MERCHANT = 'M'
    AFFILIATE = 'A'
    API_VERSION = '70544a5f74e11e13b7b61c4d98ae77e'
    AUTHENTICATE_CLASS_NAME = 'Gpf_Api_AuthService'
    AUTHENTICATE_METHOD_NAME = 'authenticate'

    attr_reader :url
    attr_accessor :debug

    def initialize (url, debug = false)
      @url = url
      @debug = debug
      @response = nil
      @role = nil
    end

    def login (username, password, role = Session::MERCHANT, languageCode = 'en-US')
      request = FormRequest.new(AUTHENTICATE_CLASS_NAME, AUTHENTICATE_METHOD_NAME, self)
      request.set_fields({
                             :username => username,
                             :password => password,
                             :roleType => role,
                             :apiVersion => API_VERSION,
                             :language => languageCode
                         })

      @response = request.send
      @role = role
      self
    end

    def loginWithAuthToken(auth_token, role = Session::MERCHANT,languageCode = 'en-US')
      request = FormRequest.new(AUTHENTICATE_CLASS_NAME, AUTHENTICATE_METHOD_NAME, self)
      request.set_fields({
                             :authToken => auth_token,
                             :roleType => role,
                             :apiVersion => API_VERSION,
                             :language => languageCode
                         })

      @response = request.send
      @role = role
      self
    end

    def id
      @response ? @response[:S] : nil
    end

    def is_merchant?
      @role && @role == MERCHANT
    end

    def is_affiliate?
      @role && @role == AFFILIATE
    end

  end
end