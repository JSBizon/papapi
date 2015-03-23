module Papapi
  require_relative 'request'
  class FormRequest < Request

    def set_field(key, value)
      @fields = [["name", "value"]] if ! @fields
      @fields.push([key, value])
    end

    def set_fields(f)
      @fields = [["name", "value"]] if ! @fields
      f.each do |key, value|
        @fields << [key, value]
      end
    end

    def response(http_response)
      FormResponse.new(http_response, self)
    end

    def to_data
      data = super
      data[:fields] = @fields if @fields
      data
    end

  end
end