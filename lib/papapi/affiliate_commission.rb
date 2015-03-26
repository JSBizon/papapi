module Papapi
  require_relative 'grid_request'
  require_relative 'multi_request'
  require_relative 'affiliate'
  class Affiliate::Commission

    def initialize(session)
      @session = session
      raise "Affiliate session is required" if !@session.is_affiliate?
    end

    def by_orders(order_ids)
      commissions = Hash[order_ids.map {|i| [i.to_s, 0.0]}]
      requests = order_ids.map do |order_id|
        r = GridRequest.new("Pap_Affiliates_Reports_TransactionsGrid", "getRows", @session)
        r.set_param("isInitRequest","Y")
        r.set_param("filterType","transaction_filter")
        r.add_filter("orderid","E",order_id)
        r
      end

      return commissions if requests.length == 0

      responses = MultiRequest.new(requests).send
      responses.each do |resp|
        resp.each do |row|
          commissions[row['orderid']] += row['commission'].to_f
        end
      end
      commissions
    end
  end
end