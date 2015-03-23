module Papapi
  require_relative 'grid_request'
  require_relative 'merchant'
  class Merchant::Commission

    def initialize(session)
      @session = session
      raise "Merchant session is required" if !@session.is_merchant?
    end

    def by_orders(order_ids,affiliate_id = nil)
      requests = order_ids.map do |order_id|
        r = GridRequest.new("Pap_Merchants_Transaction_TransactionsGrid", "getRows", @session)
        r.set_param("isInitRequest","Y")
        r.set_param("filterType","transaction_filter")
        r.add_filter("orderid","E",order_id)
        r.add_filter("userid","E",affiliate_id) if affiliate_id
        r.add_column("id")
        r.add_column("userid")
        r.add_column("commission")
        r.add_column("orderid")
        r
      end

      commissions = Hash[order_ids.map {|i| [i.to_s, 0.0]}]
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
