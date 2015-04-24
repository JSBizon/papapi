module Papapi
  require_relative 'session'
  require_relative 'grid_request'
  require_relative 'filter'
  require_relative 'affiliate'
  class Merchant

    DYNAMIC_FIELDS_MAP = {
        :url      => :data1,
        :company  => :data2,
        :street   => :data3,
        :city     => :data4,
        :state    => :data5,
        :country  => :data6,
        :zip      => :data7,
        :phone    => :data8
    }

    def initialize(session, response = nil)
      @session = session
      raise "Merchant session is required" if !@session.is_merchant?
      @response = response
    end

    def create_affiliate(fields, fields_map = Papapi::Merchant::DYNAMIC_FIELDS_MAP)
      request = Papapi::FormRequest.new('Pap_Signup_AffiliateForm', 'add', @session)
      request_fields = {'Id' => ''}
      fields.each do |name, value|
        field_real_name = fields_map.has_key?(name) ? fields_map[name] : name
        request_fields[field_real_name] = value
      end
      request.set_fields(request_fields)
      response = request.send
      response
      #affiliate = Papapi::Affiliate.new(Papapi::Session.new(@session.url).
      #                          login(request_fields[:username], request_fields[:rpassword], Papapi::Session::AFFILIATE))
      #affiliate.load
      #affiliate
    end

    def remove_affiliate(affiliate_id)
      request = Papapi::FormRequest.new('Pap_Merchants_User_AffiliateForm', 'deleteRows', @session)
      request.set_param(:moveChildAffiliates, "N")
      request.set_param(:ids, [affiliate_id])
      request.send
    end

    def load
      request = Papapi::FormRequest.new('Pap_Merchants_UserForm', 'load', @session)
      @response = request.send
      self
    end

    def list_fields(fields_map = Papapi::Merchant::DYNAMIC_FIELDS_MAP)
      request = Papapi::FormRequest.new('Pap_Merchants_Config_AffiliateFieldsForm', 'loadFieldsFromFormID', @session)
      response = request.send
      fields = {}
      first_line = true
      response[:dynamicFields].each do |field|
        if first_line
          first_line = false
          next
        end
        fields[field[1].to_sym] = {
            :formfieldid => field[0],
            :name => field[2],
            :rtype => field[3],
            :rstatus => field[4],
            :availablevalues => field[5]
        }
      end
      fields
    end

    def search_affiliates(filter: [[:rstatus,'IN','A,D,P']],
        columns: ["id", "refid", "firstname", "lastname", "username", "rstatus", "parentfirstname", "parentlastname", "dateinserted"],
        offset: 0,
        limit: 30,
        sort_col: "dateinserted",
        sort_asc: false)

      request = Papapi::GridRequest.new("Pap_Merchants_User_AffiliatesGridSimple", "getRows", @session)
      request.add_filters(filter)
      request.add_columns(columns)

      request.sort_col = sort_col
      request.sort_asc = sort_asc
      request.offset = offset
      request.limit = limit

      response = request.send

      affiliates = []

      response.rows.each do |a_data|
        affiliate = {}
        response.attributes.each_with_index do |v,i|
          affiliate[v] = a_data[i]
        end
        affiliates.push(affiliate)
      end

      affiliates
    end

    def id
      @response ? @response[:authid] : nil
    end

    def [] (key)
      @response ? @response[key.to_sym] : nil
    end

  end
end
