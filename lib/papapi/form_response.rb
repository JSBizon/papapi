module Papapi
  require_relative 'response'
  class FormResponse < Response

    def fields
      unless @fields
        @fields = {}
        self.parsed['fields'].each do |field|
          next if REMOVE_VARS.include? field[0]
          raise "Error: #{field[3]}" if field[3] && ! field[3].empty?
          if field[2]
            @fields[field[0].to_sym] = field[2]
          else
            @fields[field[0].to_sym] = field[1]
          end
        end
      end
      @fields
    end

    def [] (key)
      fields[key.to_sym]
    end

  end
end