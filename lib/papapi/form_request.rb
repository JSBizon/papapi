module Papapi
  require_relative 'request'
  class FormRequest < Request

    def set_field(key, value)
      @fields = {} if ! @fields
      @fields[key.to_sym] = value
=begin
      @fields = [["name", "value"]] if ! @fields
      @fields.push([key, value])
=end
    end

    def set_fields(f)
      @fields = {} if ! @fields
      f.each do |key, value|
        @fields[key.to_sym] = value
      end
=begin
      @fields = [["name", "value"]] if ! @fields
      f.each do |key, value|
        @fields << [key, value]
      end
=end
    end

    def response(http_response)
      FormResponse.new(http_response, self)
    end

    def to_data
      data = super
      if @fields
        data_fields = [["name", "value"]]
        @fields.each do |key, value|
          data_fields << [key, value]
        end
        data[:fields] = data_fields
      end
      data
    end

  end
end