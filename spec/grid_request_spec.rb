require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::GridRequest do

  context "load merchant transaction grid" do
    it "#send" do
      merchant_session = Papapi::Session.new(script_url).login(merchant_login, merchant_password)
      request = Papapi::GridRequest.new("Pap_Merchants_Transaction_TransactionsGrid", "getRows", merchant_session)
      request.add_filter('userid', 'E', '11111111')
      response = request.send
      expect(response.count).to be > 1
    end
  end

  context "load affiliate transaction grid" do
    it "#send" do
      affiliate_session = Papapi::Session.new(script_url).login(affiliate_login, affiliate_password, Papapi::Session::AFFILIATE)
      request = Papapi::GridRequest.new("Pap_Affiliates_Reports_TransactionsGrid", "getRows", affiliate_session)
      response = request.send
      expect(response.count).to be > 1
    end
  end
end