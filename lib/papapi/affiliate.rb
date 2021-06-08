module Papapi
  require_relative 'grid_request'
  require_relative 'multi_request'
  class Affiliate

    A_ALLOWED_FIELDS = [:username, :rpassword, :firstname, :lastname, :photo, :refid, :data1, :data2, :data3,
                        :data4, :data5, :data6, :data7, :data8, :data9, :data10, :data11, :data12, :data13,
                        :data14, :data15, :data16, :data17, :data18, :data19, :data20, :data21, :data22,
                        :data23, :data24, :data25
    ]

    M_ALLOWED_FIELDS = [:parentuserid, :rstatus, :agreeWithTerms] | A_ALLOWED_FIELDS

    attr_accessor :response

    def initialize(session, response = nil)
      @session = session
      if @session.is_affiliate?
        @load_class = 'Pap_Affiliates_Profile_PersonalDetailsForm'
        @save_class = 'Pap_Affiliates_Profile_PersonalDetailsForm'
      else
        @load_class = 'Pap_Signup_AffiliateForm'
        @save_class = 'Pap_Merchants_User_AffiliateForm'
      end
      @response = response
      @user_id = nil
      @update_fields = {}
    end


    def load
      request = Papapi::FormRequest.new(@load_class, 'load', @session)

      unless @user_id.nil?
        request.set_field("Id", @user_id)
        request.set_field("userid", @user_id)
      end

      @response = request.send
      self
    end


    def save
      raise "Affiliate id is required" if @session.is_merchant? && ! self.id

      request = Papapi::FormRequest.new(@save_class, 'save', @session)

      if @response
        @response.fields.each do |key, value|
          request.set_field(key, value) if (@session.is_affiliate? && A_ALLOWED_FIELDS.include?(key.to_sym)) ||
                                            (@session.is_merchant? && M_ALLOWED_FIELDS.include?(key.to_sym))
        end
      end

      @update_fields.each do |key, value|
        request.set_field(key, value) if (@session.is_affiliate? && A_ALLOWED_FIELDS.include?(key.to_sym)) ||
                                          (@session.is_merchant? && M_ALLOWED_FIELDS.include?(key.to_sym))
      end

      if @session.is_affiliate?
        request.set_field("Id", "")
      else
        request.set_field("Id", self.id)
      end

      @response = request.send
      @update_fields = {}
      self
    end


    def id
      @response ? @response[:userid] : @user_id
    end

    def getLoginKey
      raise "Merchant session is required"  if @session.is_affiliate?

      request = Papapi::FormRequest.new('Pap_Auth_LoginKeyService', 'getLoginKey', @session)
      request.set_param("userId", self.id)

      response = request.send

      return response[:LoginKey]
    end

    def id=(user_id)
      @user_id = user_id
    end


    def [] (key)
      @response ? @response[key.to_sym] : nil
    end


    def []= (key, value)
      raise "Field #{key} can not be modified" if (@session.is_affiliate? && ! A_ALLOWED_FIELDS.include?(key.to_sym)) ||
                                                  (@session.is_merchant? && ! M_ALLOWED_FIELDS.include?(key.to_sym))
      @update_fields[key.to_sym] = value
    end

    def to_h
      response ? response.to_h : {}
    end

  end
end
