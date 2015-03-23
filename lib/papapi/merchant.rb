module Papapi
  require_relative 'grid_request'
  class Merchant

    def initialize(session)
      @session = session
      raise "Merchant session is required" if !@session.is_merchant?
    end

    def details

    end

    def load

    end
  end
end
