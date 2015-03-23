require 'papapi'
require 'spec_helper'

RSpec.describe Papapi::Request do
  let(:session) { Papapi::Session.new(script_url,true).login(merchant_login, merchant_password) }

  context "load statistics data" do
    it "#send" do
      request = Papapi::Request.new('Pap_Merchants_Reports_TrafficStatsData', 'load', session)
      request.set_param('filters', [["rstatus", "IN", 'A'],["datetime", Papapi::Filter::DATERANGE_IS, Papapi::Filter::RANGE_LAST_30_DAYS]])
      response = request.send
      expect(response.parsed.kind_of?(Array)).to be true
      expect(response.parsed.length).to eq(6)
    end
  end
end